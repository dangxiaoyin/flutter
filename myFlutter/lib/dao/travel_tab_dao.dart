import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http; // 设置别名（包名冲突时）
import 'package:myFlutter/model/travel_tab_model.dart';

const TRAVEL_TAB_URL =
    'https://apk-1256738511.file.myqcloud.com/FlutterTrip/data/travel_page.json';

///旅拍类别接口
class TravelTabDao {
  static Future<TravelTabModel> fetch() async {
    final response = await http.get(TRAVEL_TAB_URL);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); // 解决中文乱码问题
      var result = json.decode(utf8decoder.convert(response.bodyBytes)); // 解码
      return TravelTabModel.fromJson(result);
    } else {
      throw Exception('Failed to load travel_page.json');
    }
  }
}
