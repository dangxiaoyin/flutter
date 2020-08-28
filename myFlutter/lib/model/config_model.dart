class ConfigModel {
  final String searchUrl;
  ConfigModel({this.searchUrl});

  factory ConfigModel.fromJson(Map<String, dynamic> json) {
    return ConfigModel(searchUrl: json['searchUrl']);
  }

  Map<String, dynamic> toJson() {
    return {searchUrl: searchUrl};
  }
}

/*
将接口数据直接转换为model数据模型，可根据私有字段生成fromJson、toJson
http://www.devio.org/io/tools/json-to-dart/
 */
