
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bean/HomeList.dart';
import 'package:flutter_app/bean/ProjectBean.dart';
import 'package:flutter_app/bloc/HomeBloc.dart';
import 'package:flutter_app/ui/project/ProjectTabsPage.dart';

class MyCollectPage extends StatefulWidget {
  @override
  _MyCollectPagePageState createState() => _MyCollectPagePageState();
}

class _MyCollectPagePageState extends State<MyCollectPage> {


  @override
  Widget build(BuildContext context) {
    var homeBloc = Homebloc();
    homeBloc.getMyCollectList();
    return Scaffold(
      appBar: AppBar(
        title: Text('我的收藏'),
        centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              })
      ),
      body:StreamBuilder(
          stream: homeBloc.myCollectStream,
          builder: (BuildContext context, AsyncSnapshot<ProjectBean> shot) {
            return shot.data==null? Text("加载中") : ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return  ProjectListWidget(shot.data.datas[index]);
                },
                itemCount: shot.data.datas.length,
                shrinkWrap: true);
          })
    );
  }
}
