import 'package:flutter/material.dart';
import 'package:myFlutter/model/grid_nav_model.dart';

// 继承widget: StatefulWidget或者StatelessWidget写法区别
class GridNav extends StatelessWidget {
  final GridNavModel gridNavModel;
  final String name;

// 设置name默认值 @required声明组件必需参数
  const GridNav({Key key, @required this.gridNavModel, this.name = 'xiaoming'})
      : super(key: key);

  @override
  // 重写build方法
  Widget build(BuildContext context) {
    return Text(name);
  }

  // @override
  // _GridNavState createState() => _GridNavState();
}

// class _GridNavState extends State<GridNav> {
//   @override
//   Widget build(BuildContext context) {
//     // 取到参数
//     return Text(widget.name);
//   }
// }
