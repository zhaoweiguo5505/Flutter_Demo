import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeViewState();
  }
}

class HomeViewState extends State<HomeView> {
  final List<ListItem> listData = [];
  ScrollController _scrollController = new ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < 20; i++) {
      listData.add(new ListItem("我是测试标题$i", Icons.cake));
    }
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("loadMore");
        getMoreData();
      }
    });
  }
  Future getMoreData() async{
  setState(() {
    for(int i = 0;i<20;i++){
      listData.add(new ListItem("我是加载出来的$i", Icons.title));
    }
  });
  }
  Widget HeaderView() {
    return Container(
      height: 200,
      child: Swiper(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Image.network("http://via.placeholder.com/350x150");
        },
      ),
    );
  }
  /**
   * future异步，子线程。
   * */
  Future<Null> listRefresh() async{
  setState(() {
    listData.clear();
    for(int i=0;i<20;i++){
      listData.add(new ListItem("我是刷新出来的$i", Icons.cake));
    }
  });
  }

  Widget _buildLoadText() {
    return Container(child:  Padding(
      padding: const EdgeInsets.all(18.0),
      child: Center(
        child: Text("加载中……"),
      ),
    ),color: Colors.white70,);
  }
  /**
   * 加入了controller  用来添加下拉加载，但是有一个bug就是说，如果item没有充满整个屏幕，下拉加载还是会显示，目前还没有解决方案
   * */
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: AppBar(title: Text("首页"), backgroundColor: Colors.blue),
        body: Container(
            child: RefreshIndicator(child:ListView.builder(
                itemCount: listData.length +1,
                controller:_scrollController ,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return HeaderView();
                  }
                  else if(index ==listData.length){
                    return _buildLoadText();
                  }
                  else {
                    return new ListItemWidget(listData[index - 1]);
                  }
                }) , onRefresh: listRefresh)));
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
    return new Container(
      height: 80,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              listItem.iconData,
            ),
            Text(listItem.title)
          ],
        ),
      ),
    );
  }
}
