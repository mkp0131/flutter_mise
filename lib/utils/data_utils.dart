import 'package:flutter_mise/const/status_level.dart';
import 'package:flutter_mise/model/stat_model.dart';
import 'package:flutter_mise/model/status_model.dart';

class DataUtils {
  static getTimeFromDateTime({required DateTime dateTime}) {
    return '${dateTime.year}-${dateTime.month}-${dateTime.day} ${getTimeFormatter(dateTime.hour)}:${getTimeFormatter(dateTime.minute)}';
  }

  static getTimeFormatter(int number) {
    return number.toString().padLeft(2, '0');
  }

  // 항목별 단위 얻기
  static String getUnitFromItemCode({required ItemCode itemCode}) {
    switch (itemCode) {
      case ItemCode.PM10:
        return '㎍/㎥';

      case ItemCode.PM25:
        return '㎍/㎥';

      default:
        return 'ppm';
    }
  }

  // 항목별 한글 타이틀 얻기
  static String getItemCodeKrString({required ItemCode itemCode}) {
    switch (itemCode) {
      case ItemCode.PM10:
        return '미세먼지';

      case ItemCode.PM25:
        return '초미세먼지';

      case ItemCode.NO2:
        return '이산화질소';

      case ItemCode.O3:
        return '오존';

      case ItemCode.CO:
        return '일산화탄소';

      case ItemCode.SO2:
        return '아황산가스';
    }
  }

  // 항목별 상태 객체(모델) 얻기
  static StatusModel getStatusFromItemCodeAndValue(
      {required double value, required ItemCode itemCode}) {
    final StatusModel result = statusLevel.where((status) {
      if (itemCode == ItemCode.PM10) {
        return status.minFineDust < value;
      } else if (itemCode == ItemCode.PM25) {
        return status.minUltraFineDust < value;
      } else if (itemCode == ItemCode.CO) {
        return status.minCO < value;
      } else if (itemCode == ItemCode.O3) {
        return status.minO3 < value;
      } else if (itemCode == ItemCode.NO2) {
        return status.minNO2 < value;
      } else if (itemCode == ItemCode.SO2) {
        return status.minSO2 < value;
      } else {
        throw Exception('알수없는 ItemCode입니다.');
      }
    }).last;

    return result;
  }
}
