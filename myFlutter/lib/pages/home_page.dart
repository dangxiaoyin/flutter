import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:myFlutter/dao/home_dao.dart';
import 'package:myFlutter/model/common_model.dart';
import 'package:myFlutter/model/grid_nav_model.dart';
import 'package:myFlutter/model/home_model.dart';
import 'package:myFlutter/widget/grid_nav.dart';
import 'package:myFlutter/widget/local_nav.dart';
import 'package:myFlutter/widget/sub_nav.dart'; // 轮播图插件

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// 内部类不被外部调用，要加下划线
// 继承一个HomePage的泛型
class _HomePageState extends State<HomePage> {
  List _imageUrls = [
    'http://d.zhangle.com/pic/cft/file/2018/accout_new/1-3x.png',
    'http://d.zhangle.com/pic/cft/file/2018/accout_new/2-3x.png',
    'http://d.zhangle.com/pic/cft/file/2018/accout_new/3-3x.png',
    'http://d.zhangle.com/pic/cft/file/2018/accout_new/4-3x.png'
  ];

  double appBarAlpha = 0;
  String resultString = '';
  List<CommonModel> localNavList = [];
  List<CommonModel> subNavList = [];
  GridNavModel gridNavModel;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<Null> loadData() async {
    // 2种方式

    /*
    HomeDao.fetch().then((result) {
      setState(() {
        resultString = json.encode(result.config);
      });
    }).catchError((e) {
      setState(() {
        resultString = e.toString();
      });
    });
    */

    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        localNavList = model.localNavList;
        gridNavModel = model.gridNav;
        subNavList = model.subNavList;
        // resultString = json.encode(model.config); // 将model转化为字符串
      });
      // print('homeDao:' + resultString);
    } catch (e) {
      // setState(() {
      //   resultString = e.toString();
      // });
      print(e.toString());
    }
    return null;
  }

  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });

    // print(appBarAlpha);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: Stack(
        children: <Widget>[
          // 移除padding
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            // 监听 检查每一层的child.widget
            child: NotificationListener(
              onNotification: (ScrollNotification) {
                if (ScrollNotification is ScrollUpdateNotification &&
                    ScrollNotification.depth == 0) {
                  // 滚动且是列表滚动的时候
                  _onScroll(ScrollNotification.metrics.pixels);
                }
              },
              child: ListView(
                children: <Widget>[
                  Container(
                      height: 160,
                      child: Swiper(
                        itemCount: _imageUrls.length,
                        autoplay: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Image.network(_imageUrls[index],
                              fit: BoxFit.fill);
                        },
                        pagination: SwiperPagination(),
                      )),
                  // GridNav(gridNavModel: null, name: 'Jack'),
                  Padding(
                      padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                      child: LocalNav(localNavList: localNavList)),
                  Padding(
                    padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
                    child: GridNav(gridNavModel: gridNavModel),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
                    child: SubNav(subNavList: subNavList),
                  ),
                  Container(
                    height: 800,
                    child: ListTile(
                      title: Text('resultString'),
                    ),
                  )
                ],
              ),
            ),
          ),
          Opacity(
            opacity: appBarAlpha,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('首页'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
