import 'package:flutter/material.dart';
import 'package:flutter_mise/const/colors.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle_1 = TextStyle(
      color: Colors.white,
      fontSize: 16,
    );

    return SliverAppBar(
      backgroundColor: PRIMARY_COLOR,
      // 최고로 늘어났을때의 높이 (높이 지정을 안했을시 overflow 에러가 날 수 있다.)
      expandedHeight: 500,
      // 변화하는 영역
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: SafeArea(
            child: Column(
              children: [
                Text(
                  '서울',
                  style: textStyle_1.copyWith(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  DateTime.now().toString(),
                  style: textStyle_1,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Image.asset('asset/img/mediocre.png'),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '보통',
                  style: textStyle_1.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 40,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '너무 좋네요',
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
