import 'package:flutter/material.dart';
import 'package:flutter_mise/component/card_title.dart';
import 'package:flutter_mise/component/main_card.dart';
import 'package:flutter_mise/component/main_stat.dart';
import 'package:flutter_mise/const/colors.dart';
import 'package:flutter_mise/model/stat_and_status_model.dart';
import 'package:flutter_mise/model/stat_model.dart';
import 'package:flutter_mise/model/status_model.dart';
import 'package:flutter_mise/utils/data_utils.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CategoryCard extends StatelessWidget {
  final String region;
  final Color lightColor;
  final Color darkColor;

  const CategoryCard({
    required this.region,
    required this.lightColor,
    required this.darkColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // ✅ 스크롤 가능하게 만들기 위해 높이를 지정
      child: MainCard(
        backgroundColor: lightColor,
        child: LayoutBuilder(builder: (
          context,
          constraint, // 현재 위젯의 정보(너비, 높이 등을 가지고 있는 객체)
        ) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CardTitle(
                title: '종류별 통계',
                backgroundColor: darkColor,
              ),
              Expanded(
                // ✅ 스크롤 가능하게 만들기 위해 Expanded 로 감싸기
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: PageScrollPhysics(), // 한번 스크롤에 다수의 아이템이 넘겨짐
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: ItemCode.values.map((itemCode) {
                    return ValueListenableBuilder<Box>(
                      valueListenable:
                          Hive.box<StatModel>(itemCode.name).listenable(),
                      builder: (
                        context,
                        box,
                        widget,
                      ) {
                        final recentStat = box.values.last;
                        final recentLevelFromRegion =
                            recentStat.getLevelFromRegion(region);
                        final status = DataUtils.getStatusFromItemCodeAndValue(
                          value: recentLevelFromRegion,
                          itemCode: itemCode,
                        );

                        return MainStat(
                          width: constraint.maxWidth / 3,
                          category: DataUtils.getItemCodeKrString(
                            itemCode: itemCode,
                          ),
                          imgPath: status.imagePath,
                          level: status.label,
                          stat:
                              '${recentLevelFromRegion} ${DataUtils.getUnitFromItemCode(
                            itemCode: itemCode,
                          )}',
                        );
                      },
                    );
                  }).toList(),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
