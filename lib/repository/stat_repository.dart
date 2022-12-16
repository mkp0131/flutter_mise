import 'package:dio/dio.dart';
import 'package:flutter_mise/const/data.dart';
import 'package:flutter_mise/model/stat_model.dart';

class StatRepository {
  static Future<List<StatModel>> fetchData({required ItemCode itemCode}) async {
    final res = await Dio().get(
      'http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst',
      queryParameters: {
        'serviceKey': API_KEY,
        'returnType': 'json',
        'itemCode': itemCode.name,
        'dataGubun': 'HOUR',
        'pageNo': 1,
        'numOfRows': 100,
      },
    );

    return res.data['response']['body']['items']
        .map<StatModel>(
          (item) => StatModel.fromJson(json: item),
        )
        .toList();
  }
}
