# flutter_mise

미세먼지 앱 만들기

## [flutter] 앱바의 높이 구하기 appbar

- `kToolbarHeight` 를 사용하면 Appbar 의 높이를 넣을 수 있다.

```dart
flexibleSpace: FlexibleSpaceBar(
    background: SafeArea(
      child: Container(
        // 앱바의 높이를 띄어줌. (앱바: kToolbarHeight)
        margin: EdgeInsets.only(top: kToolbarHeight),
        child: Column(
```

## [flutter] ListTile: ListView() 에서 많이 사용하는 메뉴 버튼

```dart
// ListTile: ListView() 에서 많이 사용하는 메뉴 버튼
    return ListTile(
      // 배경
      tileColor: Colors.white,
      // 선택된 상태에서의 배경
      selectedTileColor: LIGHT_COLOR,
      // 선택된 상태에서의 글자색
      selectedColor: Colors.black,
      // 선택된 상태
      selected: region == '서울',
      onTap: () {},
      title: Text(region),
    );
```

## [flutter] Drawer() 위젯 기본 사용

```dart
  return Drawer(
      backgroundColor: DARK_COLOR,
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
              selectedTileColor: LIGHT_COLOR,
              // 선택된 상태에서의 글자색
              selectedColor: Colors.black,
              // 선택된 상태
              selected: region == '서울',
              onTap: () {},
              title: Text(region),
            );
          }).toList(),
        ],
      ),
    );
```

## [flutter] 위젯 overflow hidden

- Container(), Card() 등에 해당 요소를 집어 넣는다.

```dart
clipBehavior: Clip.antiAlias,
```

## [flutter] Horizontal viewport was given unbounded height. / Vertical viewport was given unbounded height. 오류 

- Column, Row 에서 스크롤 가능한 위젯은 높이를 꼭 지정을 해줘야한다. (높이 지정이 안되었을시 무한으로 늘어난다.)
- 높이를 지정하고
- Expanded 위젯안에 넣어주어야한다.

```dart
class CategoryCard extends StatelessWidget {
  const CategoryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // ✅ 스크롤 가능하게 만들기 위해 높이를 지정
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        margin: EdgeInsets.symmetric(horizontal: 10),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              color: DARK_COLOR,
              child: Text(
                '종류별 통계',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              // ✅ 스크롤 가능하게 만들기 위해 Expanded 로 감싸기
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: PageScrollPhysics(), // 한번 스크롤에 다수의 아이템이 넘겨짐
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  30,
                  (index) => MainStat(
                    category: '미세먼지',
                    imgPath: 'asset/img/bad.png',
                    level: '보통',
                    stat: '40',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
```


## [flutter] ListView() 스크롤 방향 가로

- `scrollDirection: Axis.horizontal` 속성을 부여

```dart
  ListView(
    scrollDirection: Axis.horizontal,
```

## [flutter] ListView() 한번 스크롤에 다수의 아이템이 넘겨짐

- `physics: PageScrollPhysics()` 속성을 부여

```dart
Expanded(
    child: ListView(
    scrollDirection: Axis.horizontal,
    physics: PageScrollPhysics(), // 한번 스크롤에 다수의 아이템이 넘겨짐
```

## [flutter] LayoutBuilder() 부모의 너비 / 높이를 활용하여 자식의 너비 / 높이 설정 

- LayoutBuilder() 를 부모 위젯에 감싸준다.
- builder 함수의 constraint 파라미터로 부모의 정보를 얻는다.

```dart
child: LayoutBuilder(builder: (
  context,
  constraint, // ✅ 현재 위젯의 정보(너비, 높이 등을 가지고 있는 객체)
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Container(
        padding: EdgeInsets.all(10),
        color: DARK_COLOR,
        child: Text(
          '종류별 통계',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      Expanded(
        //  스크롤 가능하게 만들기 위해 Expanded 로 감싸기
        child: ListView(
          scrollDirection: Axis.horizontal,
          physics: PageScrollPhysics(), // 한번 스크롤에 다수의 아이템이 넘겨짐
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            30,
            (index) => MainStat(
              width: constraint.maxWidth / 3, // ✅ 부모의 너비 나누기 3
              category: '미세먼지',
              imgPath: 'asset/img/bad.png',
              level: '보통',
              stat: '40',
            ),
          ),
        ),
```

## [flutter] Dio 패키지 사용법 / http ajax 요청

- Dio 가 값을 보낼때 자동으로 encoding 을 한다. ⛔️ 즉! 인코딩된 값은 사용하지 않는다.
- JSON 키에 접근할때 `res.data['response']` 같은 형식을 사용한다.

```dart
class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  fetchData() async {
    final res = await Dio().get(
      'http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst',
      queryParameters: {
        'serviceKey': API_KEY,
        'returnType': 'json',
        'itemCode': 'PM10',
        'dataGubun': 'HOUR',
        'pageNo': 1,
        'numOfRows': 100,
      },
    );
  
    // 결과
    print(res.data);
    
    // JSON 키에 접근할때
    // res.data['response']
  }
```

- ✅ 데이터를 모델링하여 사용한다.(밑에 예제에는 데이터 모델링이 포함되어있지 않음.)

```dart
    print(
      res.data['response']['body']['items'].map(
        (item) => StatModel.fromJson(json: item),
      ),
    );
```

- ✅ 다수의 요청을 동시에 보내는 법

```dart
  Future<Map<ItemCode, List<StatModel>>> fetchData() async {
    Map<ItemCode, List<StatModel>> statModelList = {};
    // ajax 요청 보낼 Future 리스트를 생성
    List<Future> futureList = [];
    for (ItemCode itemCode in ItemCode.values) {
      // Future 리스트에 요청 보낼 것을 추가한다.
      final future = StatRepository.fetchData(itemCode: itemCode);
      futureList.add(future);
    }

    // ajax 요청을 한번에 보낸다.
    final results = await Future.wait(futureList);

    // ajax 으로 받은 값들을 우리가 원하는 형식으로 변경한다.
    for (int i = 0; i < results.length; i++) {
      statModelList.addAll({ItemCode.values[i]: results[i]});
    }

    return statModelList;
  }
```


## [flutter] Hive(하이브) 기본사용 / 전역 json 사용

### 하이브 기본사용

- hive 설치 (https://docs.hivedb.dev/#/)

```dart
dependencies:
  hive: ^[version]
  hive_flutter: ^[version]

dev_dependencies:
  hive_generator: ^[version]
  build_runner: ^[version]
```

- hive 세팅 / main() 함수에 세팅

```dart
// 꼭, hive_flutter 를 import 한다.(hive X)
import 'package:hive_flutter/hive_flutter.dart';

// Hive Box 네임
const HIVE_TEST_BOX = 'test';

void main() async {
  // Hive Init
  await Hive.initFlutter();
  // Hive Box 열기(변수를 관리하는 박스)
  await Hive.openBox(HIVE_TEST_BOX);

  runApp(const MyApp());
}
```

- 하이브에 저장된 아이템 콘솔에서 보기

```dart
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
```

- 데이터 넣기 (add, put)

```dart
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
```

- 데이터 얻기 (get)

```dart
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
```

- 데이터 삭제 (delete)

```dart
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
```

- ✅ 데이터 스트림으로 얻기

```dart
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
```

### 하이브 데이터 타입 정의

- model 에서 데이터 타입 정의

```dart
// 하이브에 타입을 지정한다. typeId 는 프라이머리키 이다!
// ✅ 하이브의 프라이머리 키를 한번 부여하면 절대 변경하지 않는다.(필요없어질 경우 건너뛴다!)
@HiveType(typeId: 1)
class StatModel {
  // 하이브 타입내에 필드를 지정한다. index 는 typeId 내에 프라이머리키 이다!
  @HiveField(0)
  final double daegu;
  @HiveField(1)
  final double chungnam;
  @HiveField(2)
  final double incheon;
  @HiveField(3)
  final double daejeon;
  @HiveField(4)
  final double gyeongbuk;
  @HiveField(5)
  final double sejong;
  @HiveField(6)
  final double gwangju;
  @HiveField(7)
  final double jeonbuk;
  @HiveField(8)
  final double gangwon;
  @HiveField(9)
  final double ulsan;
  @HiveField(10)
  final double jeonnam;
  @HiveField(11)
  final double seoul;
  @HiveField(12)
  final double busan;
  @HiveField(13)
  final double jeju;
  @HiveField(14)
  final double chungbuk;
  @HiveField(15)
  final double gyeongnam;
  @HiveField(16)
  final double gyeonggi;
  @HiveField(17)
  final DateTime dataTime;
  @HiveField(18)
  final ItemCode itemCode;

  // ✅ 하이브에 타입을 지정할경우 절대적으로 기본 constructor 가 있어야한다.
  StatModel({
    required this.daegu,
    required this.chungnam,
    required this.incheon,
    required this.daejeon,
    required this.gyeongbuk,
    required this.sejong,
    required this.gwangju,
    required this.jeonbuk,
    required this.gangwon,
    required this.ulsan,
    required this.jeonnam,
    required this.seoul,
    required this.busan,
    required this.jeju,
    required this.chungbuk,
    required this.gyeongnam,
    required this.gyeonggi,
    required this.dataTime,
    required this.itemCode,
  });
```

- model 를 generate 해준다. 
- `flutter pub run build_runner build` 명령어 실행
- model 파일에 part 로 생성된 `g.dart` 을 import 해준다.

```dart
import 'package:hive_flutter/hive_flutter.dart';

// 자동으로 생성되는 하이브 모델 파일
part 'stat_model.g.dart';

@HiveType(typeId: 2)
enum ItemCode {
  // 미세먼지
```

- main() 함수에 `.g.dart` 파일에 생생된 `Adapter()` 함수 연결해준다.

```dart
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
```

## [flutter] DateTIme 비교 / isAtSameMomentAs()

- DateTime instance 의 `isAtSameMomentAs` 메소드를 사용한다.

```dart
final DateTime now = DateTime.now();
final fetchTime = DateTime(now.year, now.month, now.day, now.hour);
final listRecentTime =
    Hive.box<StatModel>(ItemCode.PM10.name).values.last.dataTime;

if (fetchTime.isAtSameMomentAs(listRecentTime)) {
  print('이미 최신 데이터가 있습니다.');
  return;
}
```

## [flutter] 에러 메세지 유저 출력 UI / showSnackBar

- `showSnackBar` 를 활용하여 간단하게 메세지 출력이 가능 

```dart
try {
} on DioError catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text('인터넷 연결이 원할하지 않습니다.'),
  ));
}
```

## [flutter] ***Bad State: No Element 버그수정

- 앱실행시 자동으로 실행되는 코드중 null 값인 것이 있는지 확인해본다.

```dart
// recentBox.values 가 null 일때는 가드한다.
if (recentBox.values.isNotEmpty &&
    recentBox.values.last.dataTime.isAtSameMomentAs(fetchTime)) {
    print('이미 최신 데이터가 있습니다.');
    return;
}
```

```dart
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
```