import 'package:flutter/material.dart';
import 'package:flutter_demo/dialog/DialogView.dart';
import 'package:flutter_demo/dialog/ExpansionPanelListView.dart';

import 'ChipView.dart';
import 'ImageView.dart';

class PersonView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PersonViewState();
  }
}

class PersonViewState extends State<PersonView> {
  List<ListItem> datas = [];

  @override
  initState() {
    super.initState();
    datas.add(new ListItem("展示dialog", Icons.cake));
    datas.add(new ListItem("扩展列表", Icons.cake));
    datas.add(new ListItem("chip标签", Icons.cake));
    datas.add(new ListItem("图片加载", Icons.cake));
    datas.add(new ListItem("还没想好", Icons.cake));
    datas.add(new ListItem("还没想好写什么", Icons.cake));
  }

  Widget getHeader() {
    return new Container(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.amberAccent,
            height: 100,
            padding: EdgeInsets.fromLTRB(50, 20, 0, 0),
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                Container(
                  child:    Icon(Icons.person),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Column(
                    children: <Widget>[Text("登录/注册"), Text("欢迎您到来")],
                  ),
                )
              ],
            ),
          ),
          Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 2,
                      child: RaisedButton(
                        onPressed: (){
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text("抱歉，目前还不能充值")));
                        },
                        child: Text(
                          "充值",
                          style: TextStyle(color: Colors.blue),
                        ),
                      )),
                  Expanded(
                    flex: 1,
                    child: Text(""),
                  ),
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {
                      },
                      child: Text("提现"),
                    ),
                    flex: 2,
                  ),
                ],
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: AppBar(
            title: Text(
              "我的",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.amberAccent),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return getHeader();
            } else {
              return new ListItemWidget(datas[index - 1]);
            }
          },
          itemCount: datas.length + 1,
        ));
  }
}

class ListItem {
  final String title;
  final IconData iconData;

  ListItem(this.title, this.iconData);
}

class ListItemWidget extends StatelessWidget {
  final ListItem listItem;

  ListItemWidget(this.listItem);
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: Container(
        height: 80,
        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: Row(
          children: <Widget>[
            Icon(
              listItem.iconData,
            ),
            Text(listItem.title)
          ],
        ),
      ),
      onTap: (){
      if(listItem.title=="展示dialog"){
        Navigator.of(context).push(new PageRouteBuilder(
            pageBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return new DialogView();
            }));
      }
      else if(listItem.title =="chip标签"){
        Navigator.of(context).push(new PageRouteBuilder(
            pageBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return new ChipView();
            }));
      }
      else if(listItem.title=="图片加载"){
        Navigator.of(context).push(new PageRouteBuilder(
            pageBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return new ImageView();
            }));
      }
      else {
        Navigator.of(context).push(new PageRouteBuilder(
            pageBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return new ExpansionPanelListView();
            }));
      }
      },
    );
  }
}
