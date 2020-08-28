import 'package:flutter/material.dart';
import 'package:myFlutter/model/common_model.dart';
import 'package:myFlutter/model/grid_nav_model.dart';
import 'package:myFlutter/widget/webview.dart';

// 继承widget: StatefulWidget或者StatelessWidget写法区别
class LocalNav extends StatelessWidget {
  final List<CommonModel> localNavList;

// 设置name默认值 @required声明组件必需参数
  const LocalNav({Key key, @required this.localNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    if (localNavList == null) return null;
    List<Widget> items = [];
    localNavList.forEach((model) {
      items.add(_item(context, model));
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items,
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    return GestureDetector(
      onTap: () {
        print('xx - ' + model.url);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebView(
                    url: model.url,
                    statusBarColor: model.statusBarColor,
                    hideAppBar: model.hideAppBar)));
      },
      child: Column(children: <Widget>[
        Image.network(model.icon, width: 32, height: 32),
        Text(
          model.title,
          style: TextStyle(fontSize: 12),
        )
      ]),
    );
  }
}
