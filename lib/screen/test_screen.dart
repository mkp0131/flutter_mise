import 'package:flutter/material.dart';
import 'package:flutter_mise/main.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ✅ 하이브의 값을 stream 으로 가져오기!
            // 하이브의 값이 변경되면 자동으로 재실행된다!
            ValueListenableBuilder<Box>(
              valueListenable: Hive.box(HIVE_TEST_BOX).listenable(),
              builder: (context, box, widget) {
                return Column(
                  children: box.values.map((item) => Text(item)).toList(),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                // 하이브 박스
                final box = Hive.box(HIVE_TEST_BOX);
                print('----------------------------');
                print('✅ box.keys: ${box.keys.toList()}');
                print('✅ box.values: ${box.values.toList()}');
              },
              child: Text('Print Hive Box / 하이브 박스 프린트'),
            ),
            ElevatedButton(
              onPressed: () {
                // 하이브 박스
                final box = Hive.box(HIVE_TEST_BOX);
                // 데이터를 add 한다. (push 와 똑같다 마지막에 아이템을 추가 / 키가 Autoincrese 된다.)
                box.add('테스트1');
                // 데이터를 Put 한다. 데이터의 키를 지정 할 수 있다. ✅ Update 할때 사용한다.
                box.put(100, '테스트100');
              },
              child: Text('HIVE PUT DATA / 하이브 데이터 적재'),
            ),
            ElevatedButton(
              onPressed: () {
                // 하이브 박스
                final box = Hive.box(HIVE_TEST_BOX);
                // 아이템의 키로 아이템의 정보를 가져온다.
                print(box.get(100));
                // 아이템의 Index로 아이템의 정보를 가져온다.
                print(box.getAt(2));
              },
              child: Text('HIVE GET DATA / 하이브 데이터 가져오기'),
            ),
            ElevatedButton(
              onPressed: () {
                // 하이브 박스
                final box = Hive.box(HIVE_TEST_BOX);
                // 아이템의 키로 아이템을 삭제
                box.delete(100);
                // 아이템의 Index로 아이템을 삭제
                box.deleteAt(2);
              },
              child: Text('HIVE DELETE DATA / 하이브 데이터 삭제하기'),
            ),
          ],
        ),
      ),
    );
  }
}
