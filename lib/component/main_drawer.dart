import 'package:flutter/material.dart';
import 'package:flutter_mise/const/colors.dart';
import 'package:flutter_mise/const/regions.dart';

typedef OnClickRegion = void Function(String region);

// ✅ 1. Class 밖에 변수 선언
class MainDrawer extends StatelessWidget {
  final OnClickRegion onClickRegion;
  final String selectedRegion;
  final Color lightColor;
  final Color darkColor;

  const MainDrawer({
    required this.onClickRegion,
    required this.selectedRegion,
    required this.lightColor,
    required this.darkColor,
    Key? key,
  }) : super(key: key);
  // ✅ 2. Class 내부에 멤버변수 선언

  @override
  Widget build(BuildContext context) {
    // ✅ 3. build 함수 내부에 선언

    return Drawer(
      backgroundColor: darkColor,
      child: ListView(
        children: [
          // Drawer 메뉴 헤더 설정
          DrawerHeader(
            child: Text(
              '지역',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 26,
              ),
            ),
          ),
          ...regionList.map((region) {
            // ListTile: ListView() 에서 많이 사용하는 메뉴 버튼
            return ListTile(
              // 배경
              tileColor: Colors.white,
              // 선택된 상태에서의 배경
              selectedTileColor: lightColor,
              // 선택된 상태에서의 글자색
              selectedColor: Colors.black,
              // 선택된 상태
              selected: region == selectedRegion,
              onTap: () {
                onClickRegion(region);
              },
              title: Text(region),
            );
          }).toList(),
        ],
      ),
    );
  }
}
