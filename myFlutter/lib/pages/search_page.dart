import 'package:flutter/material.dart';
import 'package:myFlutter/dao/search_dao.dart';
import 'package:myFlutter/model/search_model.dart';
import 'package:myFlutter/widget/search_bar.dart';

const URL =
    'https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=长城';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

// 内部类不被外部调用，要加下划线
// 继承一个SearchPage的泛型
class _SearchPageState extends State<SearchPage> {
  String showText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: SearchBar(
              hideLeft: true,
              defaultText: '景点',
              hint: '',
              leftButtonClick: () {
                Navigator.pop(context);
              },
              onChanged: _onTextChange,
            ),
          ),
          InkWell(
            onTap: () {
              SearchDao.fetch(URL).then((SearchModel value) {
                setState(() {
                  showText = value.data[0].url;
                });
              });
            },
            child: Text('Get'),
          ),
          Text(showText)
        ],
      ),
    );
  }

  _onTextChange(text) {}
}
