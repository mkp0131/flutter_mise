import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mise/container/category_card.dart';
import 'package:flutter_mise/component/main_app_bar.dart';
import 'package:flutter_mise/component/main_drawer.dart';
import 'package:flutter_mise/const/regions.dart';
import 'package:flutter_mise/container/hourly_card.dart';
import 'package:flutter_mise/model/stat_model.dart';
import 'package:flutter_mise/model/status_model.dart';
import 'package:flutter_mise/repository/stat_repository.dart';
import 'package:flutter_mise/utils/data_utils.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String region = regionList[0];
  bool isExpanded = true;
  // 스크롤 컨트롤러
  ScrollController scrollController = ScrollController();

  // 스크롤 컨트롤러에 스크롤 리스너 부여
  @override
  initState() {
    super.initState();
    scrollController.addListener(scrollListener);
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      // Map<ItemCode, List<StatModel>> statModelList = {};
      // ajax 요청 보낼 Future 리스트를 생성
      List<Future> futureList = [];
      for (ItemCode itemCode in ItemCode.values) {
        // Future 리스트에 요청 보낼 것을 추가한다.
        final future = StatRepository.fetchData(itemCode: itemCode);
        futureList.add(future);
      }

      final DateTime now = DateTime.now();
      final fetchTime = DateTime(now.year, now.month, now.day, now.hour);
      final recentBox = Hive.box<StatModel>(ItemCode.PM10.name);

      // recentBox.values 가 null 일때는 가드한다.
      if (recentBox.values.isNotEmpty &&
          recentBox.values.last.dataTime.isAtSameMomentAs(fetchTime)) {
        print('이미 최신 데이터가 있습니다.');
        return;
      }

      // ajax 요청을 한번에 보낸다.
      final results = await Future.wait(futureList);

      // ajax 으로 받은 값들을 우리가 원하는 형식으로 변경한다.
      // {
      //   "아이템코드1": {
      //     "시간1": [],
      //     "시간2": [],
      //     "시간3": []
      //   },
      //   "아이템코드2": {
      //     "시간1": [],
      //     "시간2": [],
      //     "시간3": []
      //   }
      // }
      for (int i = 0; i < results.length; i++) {
        final key = ItemCode.values[i];
        final value = results[i];
        // ItemCode 박스를 불러온다.
        final box = Hive.box<StatModel>(key.name);
        // 데이터 넣기
        for (StatModel stat in value) {
          box.put(stat.dataTime.toString(), stat);
        }

        // 데이터 24개만 남기기
        final List allKeys = box.keys.toList();
        if (allKeys.length > 24) {
          final deleteKeys = allKeys.sublist(0, allKeys.length - 24);
          box.deleteAll(deleteKeys);
        }
      }

      /*
    * 최종적인 데이터 모습
    * {
    *   ItemCode: [
    *     StatModel,
    *     StatModel,
    *     StatModel
    *   ]
    * }
    * */
      // return ItemCode.values.fold<Map<ItemCode, List<StatModel>>>({},
      //     (previousValue, itemCode) {
      //   // ItemCode 박스를 불러온다.
      //   final box = Hive.box<StatModel>(itemCode.name);
      //   previousValue.addAll({
      //     itemCode: box.values.toList(),
      //   });
      //   return previousValue;
      // });
    } on DioError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('인터넷 연결이 원할하지 않습니다.'),
      ));
    }
  }

  // 스크롤 컨트롤러에 스크롤 리스너 삭제
  @override
  dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  void onClickRegion(region) {
    setState(() {
      this.region = region;
    });
    Navigator.of(context).pop();
  }

  scrollListener() {
    bool isExpanded = scrollController.offset < 500 - kToolbarHeight;

    if (isExpanded != this.isExpanded) {
      setState(() {
        this.isExpanded = isExpanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<StatModel>(ItemCode.PM10.name).listenable(),
      builder: (context, box, widget) {
        // box.values null 가드
        if (box.values.isEmpty) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // 가장최근 미세먼지 정보
        final StatModel pm10RecentStat = box.values.toList().last;
        final StatusModel status = DataUtils.getStatusFromItemCodeAndValue(
          value: pm10RecentStat.getLevelFromRegion(region),
          itemCode: ItemCode.PM10,
        );

        return Scaffold(
          drawer: MainDrawer(
            onClickRegion: onClickRegion,
            selectedRegion: region,
            lightColor: status.lightColor,
            darkColor: status.darkColor,
          ),
          body: Container(
            color: status.primaryColor,
            child: RefreshIndicator(
              onRefresh: () async {
                await fetchData();
              },
              child: CustomScrollView(
                // 스크롤 컨트롤러 부여
                controller: scrollController,
                slivers: [
                  MainAppBar(
                    status: status, // 현재 상태의 정보
                    stat: pm10RecentStat, // API 받아온 정보
                    region: region, // 지역
                    dateTime: pm10RecentStat.dataTime,
                    isExpanded: isExpanded,
                  ),

                  // CustomScrollView() 위젯에서 일반 위젯을 사용하기 위한 위젯
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CategoryCard(
                          region: region,
                          darkColor: status.darkColor,
                          lightColor: status.lightColor,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ...ItemCode.values.map((itemCode) {
                          return HourlyCard(
                            darkColor: status.darkColor,
                            lightColor: status.lightColor,
                            itemCode: itemCode,
                            region: region,
                          );
                        }).toList(),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
        // // API 요청 변수 저장
        // final Map<ItemCode, List<StatModel>> statList = snapshot.data!;
        // // 가장최근 미세먼지 정보
        // final StatModel pm10RecentStat = statList[ItemCode.PM10]![0];
        // final StatusModel status = DataUtils.getStatusFromItemCodeAndValue(
        //   value: pm10RecentStat.seoul,
        //   itemCode: ItemCode.PM10,
        // );
      },
    );
  }
}
