import 'package:flutter/material.dart';
import 'package:flutter_app/bean/HomeList.dart';
import 'package:flutter_app/bean/MyCollectBean.dart';
import 'package:flutter_app/bean/User.dart';
import 'package:flutter_app/bloc/UserCollectBloc.dart';
import 'package:flutter_app/common/BaseCommon.dart';
import 'package:flutter_app/http/BaseHttp.dart';
import 'package:flutter_app/utils/Toast.dart';

import '../../main.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController userPwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: ListView(
        children: <Widget>[
          headerPage(),
          Container(
            child: TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: '请输入账号',
                icon: Icon(Icons.person),
              ),
            ),
          ),
          Container(
            child: TextField(
              controller: userPwController,
              decoration: InputDecoration(
                labelText: '请输入密码',
                icon: Icon(Icons.https),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            height: 40,
            color: Colors.green,
            child: FlatButton(
                onPressed: () {
                  login();
                },
                child: Text('登录')),
          )
        ],
      ),
    );
  }

  Widget headerPage() {
    return Container(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.person,
            size: 40,
          ),
          Text(
            '未登录',
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
      decoration: BoxDecoration(color: Colors.green),
    );
  }

  void login() async {
    try {
      var post =
          await BaseHttp.getInstance().post(BaseCommon.Login, queryParameters: {
        'username': usernameController.text.toString(),
        'password': userPwController.text.toString()
      });
      var collect = await BaseHttp.getInstance().get('${BaseCommon.userCollect}0/json');
      List<HomeListBean> map = Articles.fromJson(collect.data).datas;
      UserCollectBloc.collectMap.clear();
      for(int i=0;i<map.length;i++){
        UserCollectBloc.collectMap[map[i].id] = true;
      }
      User user = User.fromJsonMap(post.data);
      StorageManager.localStorage.setItem(BaseCommon.user, user);
      Navigator.push(context, MaterialPageRoute(builder: (cx) => MyHomePage()));
    } catch (e) {
      Toast.toast(context, BaseHttp.errorMessage);
    }
  }
}
