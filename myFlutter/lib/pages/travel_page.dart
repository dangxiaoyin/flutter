import 'package:flutter/material.dart';
import 'package:myFlutter/dao/Travel_tab_dao.dart';
import 'package:myFlutter/dao/travel_dao.dart';
import 'package:myFlutter/model/travel_model.dart';
import 'package:myFlutter/model/travel_tab_model.dart';
import 'package:myFlutter/pages/travel_tab_page.dart';

class TravelPage extends StatefulWidget {
  @override
  _TravelPageState createState() => _TravelPageState();
}

// 内部类不被外部调用，要加下划线
// 继承一个TravelPage的泛型
class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin {
  TabController _controller;
  List<TravelTab> tabs = [];
  TravelTabModel travelTabModel;

  @override
  void initState() {
    _controller = TabController(length: 0, vsync: this);
    TravelTabDao.fetch().then((TravelTabModel model) {
      _controller = TabController(length: model.tabs.length, vsync: this);

      setState(() {
        tabs = model.tabs;
        travelTabModel = model;
      });
    }).catchError((e) {
      print(e);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 30),
            child: TabBar(
              controller: _controller,
              isScrollable: true,
              labelColor: Colors.black,
              labelPadding: EdgeInsets.fromLTRB(20, 0, 10, 0),
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: Color(0xff2fcfdb), width: 3),
                  insets: EdgeInsets.only(bottom: 10)),
              tabs: tabs.map<Tab>((TravelTab tab) {
                return Tab(
                  text: tab.labelName,
                );
              }).toList(),
            ),
          ),
          Flexible(
              child: TabBarView(
                  controller: _controller,
                  children: tabs.map((TravelTab tab) {
                    return TravelTabPage(
                        travelUrl: travelTabModel.url,
                        params: travelTabModel.params,
                        groupChannelCode: tab.groupChannelCode,
                        type: tab.type);
                  }).toList()))
        ],
      ),
    );
  }
}
