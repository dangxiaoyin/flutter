import 'dart:convert';

import 'package:http/http.dart' as http; // 设置别名（包名冲突时）
import 'package:myFlutter/model/search_model.dart';

class SearchDao {
  static Future<SearchModel> fetch(String url) async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // 判断接口是否返回成功
      Utf8Decoder utf8decoder = Utf8Decoder(); // 解决中文乱码问题
      var result = json.decode(utf8decoder.convert(response.bodyBytes)); // 解码
      return SearchModel.fromJson(result);
    } else {
      throw Exception('load url fail');
    }
  }
}
