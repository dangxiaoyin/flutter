// 小写中间加下划线

import 'package:myFlutter/model/common_model.dart';
import 'package:myFlutter/model/config_model.dart';
import 'package:myFlutter/model/grid_nav_model.dart';
import 'package:myFlutter/model/sales_box_model.dart';

class HomeModel {
  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final List<CommonModel> subNavList;
  final GridNavModel gridNav;
  final SalesBoxModel salesBox;

  HomeModel(
      {this.config,
      this.bannerList,
      this.localNavList,
      this.subNavList,
      this.gridNav,
      this.salesBox});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    var localNavListJson = json['localNavList'] as List; //转换为list
    List<CommonModel> localNavList = localNavListJson
        .map((i) => CommonModel.fromJson(i))
        .toList(); //然后将list 转换为对应

    var bannerListJson = json['bannerList'] as List; //转换为list
    List<CommonModel> bannerList = bannerListJson
        .map((i) => CommonModel.fromJson(i))
        .toList(); //然后将list 转换为对应

    var subNavListJson = json['subNavList'] as List; //转换为list
    List<CommonModel> subNavList = subNavListJson
        .map((i) => CommonModel.fromJson(i))
        .toList(); //然后将list 转换为对应

    return HomeModel(
      config: ConfigModel.fromJson(json['config']),
      bannerList: bannerList,
      localNavList: localNavList,
      gridNav: GridNavModel.fromJson(json['gridNav']),
      subNavList: subNavList,
    );
  }
}
