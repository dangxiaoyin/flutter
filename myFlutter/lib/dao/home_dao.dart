// 请求网络获取返回数据需要导入以下包
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http; // 设置别名（包名冲突时）
import 'package:myFlutter/model/home_model.dart';

const Home_URL = "http://www.devio.org/io/flutter_app/json/home_page.json";

// 首页大接口
class HomeDao {
  static Future<HomeModel> fetch() async {
    final response = await http.get(Home_URL);
    if (response.statusCode == 200) {
      // 判断接口是否返回成功
      Utf8Decoder utf8decoder = Utf8Decoder(); // 解决中文乱码问题
      var result = json.decode(utf8decoder.convert(response.bodyBytes)); // 解码
      return HomeModel.fromJson(result);
    } else {
      throw Exception('load url fail');
    }
  }
}
