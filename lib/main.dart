import 'package:flutter/material.dart';
import 'package:flutter_app/ui/home/HomePage.dart';
import 'package:flutter_app/ui/mine/LoginPage.dart';
import 'package:flutter_app/ui/mine/MinePage.dart';
import 'package:flutter_app/ui/project/ProjectPage.dart';
import 'package:flutter_app/ui/widgetclassify/StructureCategoryPage.dart';
import 'package:flutter_app/ui/wxarticle/WxarticlePage.dart';

import 'http/BaseHttp.dart';

void main() async{
  await StorageManager.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>  with SingleTickerProviderStateMixin{
  TabController  tabController;
  List<Widget> viewList;
  List<Widget> bottomtabList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    viewList = List();
    bottomtabList = List();
    viewList.add(HomePage());
    viewList.add(ProjectPage());
    viewList.add(WxartpiclePage());
    viewList.add(StructureCategoryPage());
    viewList.add(MinePage());
    bottomtabList.add(Tab(icon: Icon(Icons.home),text: '首页'));
    bottomtabList.add(Tab(icon: Icon(Icons.android),text: '项目'));
    bottomtabList.add(Tab(icon: Icon(Icons.group),text: '公众号'));
    bottomtabList.add(Tab(icon: Icon(Icons.group_work),text: '体系',));
    bottomtabList.add(Tab(icon: Icon(Icons.person),text: '我的'));
    tabController = TabController(length: viewList.length, vsync: this);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:TabBarView(
        children: viewList,
        controller: tabController,
      ),
      bottomNavigationBar: Material(
        child: TabBar(tabs: bottomtabList,controller: tabController,
        labelColor: Colors.blue,
          unselectedLabelColor: Colors.black,
        ),
      ),
    );
  }
}
