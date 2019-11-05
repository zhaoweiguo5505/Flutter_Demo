

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/HomeBloc.dart';
import 'package:flutter_app/common/BaseCommon.dart';
import 'package:flutter_app/ui/home/HomePage.dart';

import '../../bean/HomeList.dart';

class ArticleChildPage extends StatefulWidget{
  int id;
  String title;
  ArticleChildPage(this.id,this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ArticleChildPageState(id,this.title);
  }

}

class ArticleChildPageState extends State<ArticleChildPage>{
  int id;
  String title;
  ArticleChildPageState(this.id,this.title);
  int page = 0;
  @override
  Widget build(BuildContext context) {
    Homebloc homebloc = new Homebloc();
    homebloc.getArticleChild('${BaseCommon.articleList}$page/json?cid=$id');
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: StreamBuilder(stream: homebloc.articleStream,builder: (BuildContext context, AsyncSnapshot<Articles> shot){
        if(shot.data==null){
          return Center(
            child: Text('加载中'),
          );
        }
        else{
          return ListView.builder(itemCount:shot.data.datas.length,itemBuilder: (BuildContext context,int index){
            return ListItemWidget(shot.data.datas[index]);
          }, shrinkWrap: true);
        }
      }),
    );
  }
}