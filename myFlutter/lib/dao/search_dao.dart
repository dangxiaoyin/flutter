import 'dart:convert';

import 'package:http/http.dart' as http; // 设置别名（包名冲突时）
import 'package:myFlutter/model/search_model.dart';

class SearchDao {
  static Future<SearchModel> fetch(String url, String text) async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // 判断接口是否返回成功
      Utf8Decoder utf8decoder = Utf8Decoder(); // 解决中文乱码问题
      var result = json.decode(utf8decoder.convert(response.bodyBytes)); // 解码
      // 只有当当前输入的内容和服务器返回的内容一致时才渲染
      SearchModel model = SearchModel.fromJson(result);
      model.keyword = text;
      return model;
    } else {
      throw Exception('load url fail');
    }
  }
}
