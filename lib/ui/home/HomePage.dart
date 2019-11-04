import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bean/HomeBanner.dart';
import 'package:flutter_app/bean/HomeList.dart';
import 'package:flutter_app/bloc/HomeBloc.dart';
import 'package:flutter_app/bloc/UserCollectBloc.dart';
import 'package:flutter_app/common/BaseCommon.dart';
import 'package:flutter_app/http/BaseHttp.dart';
import 'package:flutter_app/ui/WebViewPage.dart';
import 'package:flutter_app/utils/Toast.dart';
import 'package:flutter_app/utils/my_card.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var homeBloc = Homebloc();
    homeBloc.getData(BaseCommon.HomeBanner);
    homeBloc.getData(BaseCommon.HomeList);
    return Scaffold(
      appBar: AppBar(
        title: Text('玩Android'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[createBanner(homeBloc), createMassage(homeBloc)],
          ),
        ),
      ),
    );
  }

  Widget createBanner(Homebloc homeBloc) {
    return StreamBuilder(
        stream: homeBloc.bannerStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<HomeBanner>> shapshot) {
          if (homeBloc.listBanner == null) {
            return Container(
              child: Center(
                child: Text('加载中'),
              ),
            );
          } else {
            return Container(
              height: 200,
              child: Swiper(
                itemCount: homeBloc.listBanner.length,
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(homeBloc.listBanner[index].imagePath);
                },
              ),
            );
          }
        });
  }

  Widget createMassage(Homebloc homeBloc) {
    return StreamBuilder(
        stream: homeBloc.ListStream,
        builder: (BuildContext context, AsyncSnapshot shapshot) {
          if (homeBloc.homeList == null) {
            return Text('加载中');
          } else {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return ListItemWidget(homeBloc.homeList.datas[index]);
              },
              itemCount: homeBloc.homeList.datas.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            );
          }
        });
  }
}
class ListItemWidget extends StatefulWidget{
  HomeListBean bean;
  ListItemWidget(this.bean);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ListItemState(bean);
  }

}
class ListItemState extends State {
  HomeListBean bean;

  ListItemState(this.bean);

  @override
  Widget build(BuildContext context) {
    return MyCard(
      margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
      padding: EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          GestureDetector(
            child: Container(
              width: 50,
              child: Icon(
                  UserCollectBloc.isCollect(bean.id)?Icons.favorite:Icons.favorite_border,
                color: Colors.red,
              ),
            ),
            onTap: () {
              addCollect(bean.id, context);
            },
          ),
          Expanded(
            child: GestureDetector(
              child:
              Container(
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          bean.title,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 20, 0, 5),
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          children: <Widget>[
                            Text('时间：${bean.niceShareDate}'),
                            Expanded(
                                child: Text(
                                  '作者：${bean.chapterName}',
                                  textAlign: TextAlign.right,
                                ))
                          ],
                        ),
                      )
                    ],
                  )),
              onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (cx) => WebViewPage(bean.link,bean.title)));
              },
            ),
          )
        ],
      ),
    );
  }

/**
 * 收藏调用接口
 * */
void addCollect(int id, BuildContext context) async {
  await UserCollectBloc.addAndDeleteCollect(id, context);
  setState(() {
  });
}
}
