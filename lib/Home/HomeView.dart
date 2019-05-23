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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < 20; i++) {
      listData.add(new ListItem("我是测试标题$i", Icons.cake));
    }
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: AppBar(title: Text("首页"), backgroundColor: Colors.blue),
        body: Container(
            child: ListView.builder(
                itemCount: listData.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return HeaderView();
                  } else {
                    return new ListItemWidget(listData[index - 1]);
                  }
                })));
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
