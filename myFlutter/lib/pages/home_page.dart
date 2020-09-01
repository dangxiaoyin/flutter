import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:myFlutter/dao/home_dao.dart';
import 'package:myFlutter/model/common_model.dart';
import 'package:myFlutter/model/grid_nav_model.dart';
import 'package:myFlutter/model/home_model.dart';
import 'package:myFlutter/model/sales_box_model.dart';
import 'package:myFlutter/pages/search_page.dart';
import 'package:myFlutter/widget/grid_nav.dart';
import 'package:myFlutter/widget/loading_container.dart';
import 'package:myFlutter/widget/local_nav.dart';
import 'package:myFlutter/widget/sales_box.dart';
import 'package:myFlutter/widget/search_bar.dart';
import 'package:myFlutter/widget/sub_nav.dart';
import 'package:myFlutter/widget/webview.dart'; // 轮播图插件

const APPBAR_SCROLL_OFFSET = 100;
const SEARCH_BAR_DEFAULT_TEXT = '网红打卡地 景点 酒店 美事';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// 内部类不被外部调用，要加下划线
// 继承一个HomePage的泛型
class _HomePageState extends State<HomePage> {
  double appBarAlpha = 0;
  String resultString = '';
  List<CommonModel> localNavList = [];
  List<CommonModel> subNavList = [];
  List<CommonModel> bannerList = [];
  GridNavModel gridNavModel;
  SalesBoxModel salesBoxModel;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  Future<Null> _handleRefresh() async {
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
        salesBoxModel = model.salesBox;
        bannerList = model.bannerList;
        _loading = false;
        // resultString = json.encode(model.config); // 将model转化为字符串
      });

      // print('homeDao:' + resultString);
    } catch (e) {
      // setState(() {
      //   resultString = e.toString();
      // });
      setState(() {
        _loading = false;
      });
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
      body: LoadingContainer(
        isLoading: _loading,
        child: Stack(
          children: <Widget>[
            // 移除padding
            MediaQuery.removePadding(
              removeTop: true,
              context: context,
              // 监听 检查每一层的child.widget
              // 下拉刷新
              child: RefreshIndicator(
                onRefresh: _handleRefresh,
                child: NotificationListener(
                  onNotification: (ScrollNotification) {
                    if (ScrollNotification is ScrollUpdateNotification &&
                        ScrollNotification.depth == 0) {
                      // 滚动且是列表滚动的时候
                      _onScroll(ScrollNotification.metrics.pixels);
                    }
                  },
                  child: _listView,
                ),
              ),
            ),
            _appBar,
          ],
        ),
      ),
    );
  }

  Widget get _listView {
    return ListView(
      children: <Widget>[
        _banner,
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
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SalesBox(salesBox: salesBoxModel),
        ),
      ],
    );
  }

  Widget get _appBar {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          height: 80.0,
          decoration: BoxDecoration(
              color:
                  Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255)),
          child: SearchBar(
            searchBarType: appBarAlpha > 0.2
                ? SearchBarType.homeLight
                : SearchBarType.home,
            inputBoxClick: _jumpToSearch,
            speakClick: _jumpToSpeak,
            defaultText: SEARCH_BAR_DEFAULT_TEXT,
            leftButtonClick: () {},
          ),
        ),
        Container(
          height: appBarAlpha > 0.2 ? 0.5 : 0,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]),
        )
      ],
    );
  }

  Widget get _banner {
    return Container(
        height: 160,
        child: Swiper(
          itemCount: bannerList.length,
          autoplay: true,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    CommonModel model = bannerList[index];
                    return WebView(
                      url: model.url,
                      title: model.title,
                      hideAppBar: model.hideAppBar,
                    );
                  }),
                );
              },
              child: Image.network(bannerList[index].icon, fit: BoxFit.fill),
            );
          },
          pagination: SwiperPagination(),
        ));
  }

  _jumpToSearch() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SearchPage(
        hint: SEARCH_BAR_DEFAULT_TEXT,
      );
    }));
  }

  _jumpToSpeak() {}
}
