import 'package:flutter/material.dart';
import 'package:flutter_mise/model/stat_model.dart';
import 'package:flutter_mise/screen/home_screen.dart';
import 'package:flutter_mise/screen/test_screen.dart';
// 꼭, hive_flutter 를 import 한다.(hive X)
import 'package:hive_flutter/hive_flutter.dart';

// Hive Box 네임
const HIVE_TEST_BOX = 'test';

void main() async {
  // Hive Init
  await Hive.initFlutter();
  // Hive Box 열기(변수를 관리하는 박스)
  await Hive.openBox(HIVE_TEST_BOX);
  // 아답터 넣기 (아딥터를 통해서 데이터를 컨트롤한다)
  Hive.registerAdapter<StatModel>(StatModelAdapter());
  Hive.registerAdapter<ItemCode>(ItemCodeAdapter());

  // 데이터의 컬럼별로 Hive Box 를 연다.
  for (ItemCode itemCode in ItemCode.values) {
    await Hive.openBox<StatModel>(itemCode.name);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'sunflower',
      ),
      home: const HomeScreen(),
    );
  }
}
