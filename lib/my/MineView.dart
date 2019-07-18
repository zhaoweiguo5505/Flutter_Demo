import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/Toast.dart';

class MineView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MineViewState();
  }
}

class MineViewState extends State<MineView> {
  List<ListItem> datas = [];

  @override
  void initState() {
    super.initState();
    datas.add(new ListItem("我的会员", Icons.android));
    datas.add(new ListItem("委托管理", Icons.transform));
    datas.add(new ListItem("安全中心", Icons.assistant));
    datas.add(new ListItem("提交工单", Icons.comment));
    datas.add(new ListItem("帮助中心", Icons.help));
    datas.add(new ListItem("注册邀请", Icons.share));
    datas.add(new ListItem("设置", Icons.settings));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return getHeader();
            } else {
              return new ListItemWidget(datas[index - 1]);
            }
          },
          itemCount: datas.length + 1,
        ),
      ),
    );
  }

  Widget getHeader() {
    return new Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff4a71a5), Color(0xff6b99ab)],
                    begin: FractionalOffset(1, 0),
                    end: FractionalOffset(0, 1))),
            height: 100,
            padding: EdgeInsets.fromLTRB(50, 20, 0, 0),
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                Container(
                  child: Icon(Icons.person),
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
                        onPressed: () {
                          Toast.toast(context, '很抱歉，暂时不开放充值,你可以给我的支付宝充钱');
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
                        Toast.toast(context, '到嘴的鸭子你还想飞走？');
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
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.5, color: Colors.grey))),
        height: 50,
        padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
        child: Row(
          children: <Widget>[
            Icon(
              listItem.iconData,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text(listItem.title),
            )
          ],
        ),
      ),
      onTap: () {},
    );
  }
}
