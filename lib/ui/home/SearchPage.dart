

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bean/HomeList.dart';
import 'package:flutter_app/bloc/HomeBloc.dart';
import 'package:flutter_app/ui/home/HomePage.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Homebloc homebloc = Homebloc();
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: '请输入要搜索的内容',
              hintStyle: TextStyle(color: Colors.white)

          ),

          textInputAction: TextInputAction.search,

        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: (){
            homebloc.getSearchList(controller.text.toString(),0);
          })
        ],
      ),
      body:StreamBuilder(stream:homebloc.searchStream,builder: (BuildContext context,AsyncSnapshot<Articles> shot){
            if(shot.data==null){
              return Text('测试');
            }
            else{
              return ListView.builder(itemBuilder: (BuildContext context,int index){
                return ListItemWidget(shot.data.datas[index]);
              },itemCount: shot.data.datas.length,
              shrinkWrap: true);
            }
      }),
    );
  }
}


