import 'package:hive_flutter/hive_flutter.dart';

// 자동으로 생성되는 하이브 모델 파일
part 'stat_model.g.dart';

@HiveType(typeId: 2)
enum ItemCode {
  // 미세먼지
  @HiveField(0)
  PM10,
  // 초미세먼지
  @HiveField(1)
  PM25,
  // 이산화질소
  @HiveField(2)
  NO2,
  // 오존
  @HiveField(3)
  O3,
  // 일산화탄소
  @HiveField(4)
  CO,
  // 이황산가스
  @HiveField(5)
  SO2,
}

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

  StatModel.fromJson({required Map<String, dynamic> json})
      : daegu = double.parse(json['daegu'] ?? '0'),
        chungnam = double.parse(json['chungnam'] ?? '0'),
        incheon = double.parse(json['incheon'] ?? '0'),
        daejeon = double.parse(json['daejeon'] ?? '0'),
        gyeongbuk = double.parse(json['gyeongbuk'] ?? '0'),
        sejong = double.parse(json['sejong'] ?? '0'),
        gwangju = double.parse(json['gwangju'] ?? '0'),
        jeonbuk = double.parse(json['jeonbuk'] ?? '0'),
        gangwon = double.parse(json['gangwon'] ?? '0'),
        ulsan = double.parse(json['ulsan'] ?? '0'),
        jeonnam = double.parse(json['jeonnam'] ?? '0'),
        seoul = double.parse(json['seoul'] ?? '0'),
        busan = double.parse(json['busan'] ?? '0'),
        jeju = double.parse(json['jeju'] ?? '0'),
        chungbuk = double.parse(json['chungbuk'] ?? '0'),
        gyeongnam = double.parse(json['gyeongnam'] ?? '0'),
        gyeonggi = double.parse(json['gyeonggi'] ?? '0'),
        dataTime = DateTime.parse(json['dataTime']),
        itemCode = parseItemCode(json['itemCode']);

  static ItemCode parseItemCode(String raw) {
    if (raw == 'PM2.5') {
      return ItemCode.PM25;
    }
    return ItemCode.values.firstWhere((element) => element.name == raw);
  }

  double getLevelFromRegion(String region) {
    if (region == '서울') {
      return seoul;
    } else if (region == '경기') {
      return gyeonggi;
    } else if (region == '대구') {
      return daegu;
    } else if (region == '충남') {
      return chungnam;
    } else if (region == '인천') {
      return incheon;
    } else if (region == '대전') {
      return daejeon;
    } else if (region == '경북') {
      return gyeongbuk;
    } else if (region == '세종') {
      return sejong;
    } else if (region == '광주') {
      return gwangju;
    } else if (region == '전북') {
      return jeonbuk;
    } else if (region == '강원') {
      return gangwon;
    } else if (region == '울산') {
      return ulsan;
    } else if (region == '전남') {
      return jeonnam;
    } else if (region == '부산') {
      return busan;
    } else if (region == '제주') {
      return jeju;
    } else if (region == '충북') {
      return chungbuk;
    } else if (region == '경남') {
      return gyeongnam;
    } else {
      throw Exception('알수없는 지역입니다.');
    }
  }

  @override
  String toString() {
    return dataTime.toString();
  }
}
