import 'package:flutter/material.dart';
import 'package:flutter_demo/net/http.dart';
import 'package:flutter_demo/utils/Toast.dart';
import 'dart:convert';

import '../main.dart';
import 'IdentifyCodeView.dart';

class LoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _userPasswordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("登录/注册"),
        leading: Icon(Icons.backspace),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(50),
            child: Icon(Icons.home),
          ),
          new Container(
            margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: new Text("欢迎登陆", style: TextStyle(fontSize: 20))),
                Text("注册账号")
              ],
            ),
          ),
          /**
           * 输入框 具体请点击看源码，同时附加百度
           * */
          new TextField(
            controller: _userNameController,
            decoration: new InputDecoration(
                contentPadding: const EdgeInsets.only(top: 10.0),
                icon: new Icon(Icons.perm_identity),
                labelText: "请输入用户名",
                helperText: "注册时填写的名字"),
          ),
          new TextField(
            controller: _userPasswordController,
            decoration: new InputDecoration(
                contentPadding: const EdgeInsets.only(top: 10.0),
                icon: new Icon(Icons.lock),
                labelText: "请输入密码",
                helperText: "登录密码"),
            obscureText: true,
          ),
          new Builder(builder: (BuildContext context) {
            return new Container(
              margin: EdgeInsets.all(20),
              child: RaisedButton(
                  onPressed: () {
                    var userName = _userNameController.text.toString();
                    var passWord = _userPasswordController.text.toString();
                    getLoginStatus(userName, passWord);
//                  onTextClear();
                  },
                  color: Colors.blue,
                  highlightColor: Colors.lightBlueAccent,
                  disabledColor: Colors.lightBlueAccent,
                  child: new Text(
                    "登录",
                    style: new TextStyle(color: Colors.white),
                  )),
            );
          }),
          new Container(
            alignment: Alignment.bottomCenter,
            child: Text('注册'),
          )
        ],
      ),
    );
  }

  void getLoginStatus(String userName, String passWord) async {
    var post = await Http.getInstance()
        .post("v1/login", data: {'name': userName, 'pwd': passWord});
    var encode = json.encode(post);
    if (json.decode(post)['code'] == 1) {
      Navigator.of(context).push(new PageRouteBuilder(pageBuilder:
          (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
        return new MyHomePage();
      }));
    }
    selectCodeMsg(json.decode(post)['code'], json.decode(post)['msg']);
  }

  void selectCodeMsg(int encode, String msg) {
    switch (encode) {
      case 7:
      case 6:
        Toast.toast(context, "非常用设备,需要校验验证码");
        Navigator.of(context).push(new PageRouteBuilder(pageBuilder:
            (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
          return new IdentifyCodeView();
        }));
        break;
      case 5:
        Toast.toast(context, "账户出现安全隐患被冻结，请尽快联系客服");
        break;
      case 4:
        Toast.toast(context, "用户名或密码错误");
        break;
      case 3:
        Toast.toast(context, "密码错误次数过多被限制登录");
        break;
      case 2:
        Toast.toast(context, "密码为空");
        break;
      case 200:
        getLogin();
        break;
      default:
        Toast.toast(context, "登录失败，请重新登录");
        break;
    }
  }

  void getLogin() {}
}

//Expanded 主要是用于一些整行显示 他可以说是Adnroid里面的Linearlayoug的weight;用他来实现控件的 居右  居左
