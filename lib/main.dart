import 'package:flutter/material.dart';
import 'package:flutter_demo/shopcar/ShopCarView.dart';

import 'Home/HomeView.dart';
import 'login/LoginView.dart';
import 'my/PersonView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginView(),
    );
  }
}
/**
 * stateFluWidget 这个是用于点击事件，还有一种StalessWidget 那种没有点击事件。
 * 至于为什么我下面集成了 strate<> 这就是一种模式，就这么写的，我也不太清楚。
 */

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  TabController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new TabController(
        length: 3,   //Tab页的个数
        vsync: this //动画效果的异步处理，默认格式
    );
  }
  /**
   * tabbarview和  tabbar结合  用于首页切换布局，这种比较简单，所以直接使用
   * */
    @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: TabBarView( controller:controller,children: [
        HomeView(),
        ShopCarView(),
        PersonView()
      ]),
      /**
       * tabbar和tabbarview使用同一个 controller来控制显示隐藏，
       * */
      bottomNavigationBar: Material(
        child: TabBar(tabs: [
          Tab(text: "首页",icon: Icon(Icons.home)),
          Tab(text: "购物车",icon: Icon(Icons.shopping_cart)),
          Tab(text: "个人中心",icon: Icon(Icons.person))
        ],
          controller: controller,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.black,
        ),
      ),
    );
  }
}
