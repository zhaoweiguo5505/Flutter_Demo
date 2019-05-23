import 'package:flutter/material.dart';
import 'package:flutter_demo/Home/HomeView.dart';

import '../main.dart';

class LoginView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView>{
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _userPasswordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("登录/注册"),leading: Icon(Icons.backspace),centerTitle: true,),
      body: Column(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.fromLTRB(10, 20, 10, 0),

            child: Row(
              children: <Widget>[
                Expanded(
                  child:new Text("欢迎登陆",style: TextStyle(fontSize: 20))),
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
            return new RaisedButton(
                onPressed: () {
                  var userName=   _userNameController.text.toString();
                  var passWord=   _userPasswordController.text.toString();
                  if (userName == passWord ) {
                    Navigator.of(context).push(new PageRouteBuilder(
                        pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation) {
                          return new MyHomePage();
                        }));
                  } else {
                    Scaffold.of(context).showSnackBar(
                        new SnackBar(content: new Text("登录失败，用户名密码有误")));
                  }
//                  onTextClear();
                },
                color: Colors.blue,
                highlightColor: Colors.lightBlueAccent,
                disabledColor: Colors.lightBlueAccent,
                child: new Text(
                  "登录",
                  style: new TextStyle(color: Colors.white),
                ));
          })
        ],
      ),

    );
  }

}

//Expanded 主要是用于一些整行显示 他可以说是Adnroid里面的Linearlayoug的weight;用他来实现控件的 居右  居左