import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_demo/net/http.dart';
import 'package:flutter_demo/utils/Toast.dart';

import '../main.dart';

class IdentifyCodeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IdentifyCodeState();
}

class IdentifyCodeState extends State<IdentifyCodeView> {
  TextEditingController editCodeController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sendCode();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('验证手机设备'),
        centerTitle: true,
        leading: Icon(Icons.arrow_back_ios),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            TextField(
              controller: editCodeController,
              decoration: new InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 10.0),
                  icon: new Icon(Icons.perm_identity),
                  labelText: "请输入验证码",
                  helperText: "短信验证码"),
            ),
            new Builder(builder: (BuildContext context) {
              return new Container(
                margin: EdgeInsets.all(20),
                child: RaisedButton(
                    onPressed: () {
//                      requstCode(editCodeController.text.toString());
                    },
                    color: Colors.blue,
                    highlightColor: Colors.lightBlueAccent,
                    disabledColor: Colors.lightBlueAccent,
                    child: new Text(
                      "登录",
                      style: new TextStyle(color: Colors.white),
                    )),
              );
            })
          ],
        ),
      ),
    );
  }

  void sendCode() async {
    var data = await Http.getInstance().get("v1/sendLoginCode",
        data: {'checkcode': '', 'name': '18533966971'});
    print(data);
    if (json.decode(data)['code'] == '200') {
      Toast.toast(context, "验证码发送成功");
    }
  }

  void requstCode() async {
    var data = await Http.getInstance().post("v1/secLogin",
        data: {'code': editCodeController.text.toString()});
    if (json.decode(data)['code'] == 200) {
      Toast.toast(context, "验证成功");
    } else {
      Toast.toast(context, "登录失败");
    }
  }

  void getSession() async {
    Navigator.of(context).push(new PageRouteBuilder(pageBuilder:
        (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
      return new MyHomePage();
    }));
  }
}
