import 'package:flutter/material.dart';
import 'package:myFlutter/pages/home_page.dart';
import 'package:myFlutter/pages/my_page.dart';
import 'package:myFlutter/pages/search_page.dart';
import 'package:myFlutter/pages/travel_page.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

// 内部类不被外部调用，要加下划线
// 继承一个TabNavigator的泛型
class _TabNavigatorState extends State<TabNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _currentIndex = 0;
  final _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[
          HomePage(),
          SearchPage(
            hideLeft: true,
          ),
          TravelPage(),
          MyPage()
        ],
        // 禁止tab滚动
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            _controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: _defaultColor),
              activeIcon: Icon(Icons.home, color: _activeColor),
              // ignore: deprecated_member_use
              title: Text(
                '首页',
                style: TextStyle(
                    color: _currentIndex != 0 ? _defaultColor : _activeColor),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, color: _defaultColor),
              activeIcon: Icon(Icons.search, color: _activeColor),
              // ignore: deprecated_member_use
              title: Text(
                '搜索',
                style: TextStyle(
                    color: _currentIndex != 1 ? _defaultColor : _activeColor),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt, color: _defaultColor),
              activeIcon: Icon(Icons.camera_alt, color: _activeColor),
              // ignore: deprecated_member_use
              title: Text(
                '旅拍',
                style: TextStyle(
                    color: _currentIndex != 2 ? _defaultColor : _activeColor),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, color: _defaultColor),
              activeIcon: Icon(Icons.account_circle, color: _activeColor),
              // ignore: deprecated_member_use
              title: Text(
                '我的',
                style: TextStyle(
                    color: _currentIndex != 3 ? _defaultColor : _activeColor),
              ),
            ),
          ]),
    );
  }
}
