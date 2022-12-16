import 'package:flutter/material.dart';
import 'package:flutter_mise/const/colors.dart';
import 'package:flutter_mise/model/stat_model.dart';
import 'package:flutter_mise/model/status_model.dart';
import 'package:flutter_mise/model/status_model.dart';
import 'package:flutter_mise/utils/data_utils.dart';

class MainAppBar extends StatelessWidget {
  final StatusModel status;
  final StatModel stat;
  final String region;
  final DateTime dateTime;
  final bool isExpanded;

  const MainAppBar({
    required this.status,
    required this.stat,
    required this.region,
    required this.dateTime,
    required this.isExpanded,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle_1 = TextStyle(
      color: Colors.white,
      fontSize: 16,
    );

    return SliverAppBar(
      // 아래로 스크롤이 끝까지 되더라도 최소한의 헤더가 fixed 로 남아 있음.
      pinned: true,
      // 헤더의 타이틀
      title: isExpanded
          ? null
          : Text(
              '${region} ${DataUtils.getTimeFromDateTime(dateTime: dateTime)}'),
      // 타이틀 중앙정렬
      centerTitle: true,
      // 배경 색상
      backgroundColor: status.primaryColor,
      // 최고로 늘어났을때의 높이 (높이 지정을 안했을시 overflow 에러가 날 수 있다.)
      expandedHeight: 500,
      // 변화하는 영역
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Container(
            // 앱바의 높이를 띄어줌. (앱바: kToolbarHeight)
            margin: EdgeInsets.only(top: kToolbarHeight),
            child: Column(
              children: [
                Text(
                  region,
                  style: textStyle_1.copyWith(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  DataUtils.getTimeFromDateTime(dateTime: stat.dataTime),
                  style: textStyle_1,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Image.asset(status.imagePath),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  status.label,
                  style: textStyle_1.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 40,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  status.comment,
                  style: textStyle_1.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
