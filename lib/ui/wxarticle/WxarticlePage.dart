


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bean/WxarticleHistoryBean.dart';
import 'package:flutter_app/bean/WxarticleListBean.dart';
import 'package:flutter_app/bloc/WxartpicleBloc.dart';
import 'package:flutter_app/ui/WebViewPage.dart';

class WxartpiclePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WxartpiclePageState();
  }
}

class WxartpiclePageState extends State<WxartpiclePage>{
  var mSelectNameIndex = 0;
  ScrollController _scrollController = new ScrollController();
  var mBloc = WxartpicleBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if(mBloc.wxarticleListBean!=null){
//          print('${mBloc.historyBean.curPage++}测试一下${mBloc.historyBean.curPage}');
          mBloc.getWxarticleHistory(mBloc.wxarticleListBean[mSelectNameIndex].id,++mBloc.historyBean.curPage);
        }
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement
    mBloc.getWxartpicleList();
    return StreamBuilder(stream:mBloc.wxartpicleStream,builder: (BuildContext context,AsyncSnapshot shot){
      if(mBloc.wxarticleListBean==null){
        return Text('加载中');
      }
      else{
        return Container(
          child: Row(
            children: <Widget>[
              Expanded(child:
              getWxartpicleList(mBloc),
                flex: 1,
              ),
              Expanded(child:getWxartpicleDetails(mBloc),
                flex: 3,)
            ],
          ),
        );
      }
    });
  }
  //获取公众号列表
  Widget getWxartpicleList(WxartpicleBloc mBloc){
          return ListView.builder(itemBuilder: (BuildContext context,int index){
              return GestureDetector(
                child: WxNameListPage(mBloc.wxarticleListBean[index],index==mSelectNameIndex),
                onTap: (){
                 updateIndex(index);
                },
              );
          },itemCount: mBloc.wxarticleListBean.length,

          );
  }
    //获取公众号详细文章
  Widget getWxartpicleDetails(WxartpicleBloc mBloc) {
   if(mBloc.wxarticleListBean!=null){
     mBloc.getWxarticleHistory(mBloc.wxarticleListBean[mSelectNameIndex].id,1);
     return StreamBuilder(stream:mBloc.historyStream,builder: (BuildContext context,AsyncSnapshot shot){
        if(mBloc.historyBean==null){
          return Text('加载中');
        }
        else{
          return RefreshIndicator(
            child: ListView.builder(controller:_scrollController,itemBuilder: (BuildContext context,int index){
              return GestureDetector(
                child: WxarticleDetailsPage(mBloc.historyBean.datas[index]),
                onTap: (){//跳转webview
                  Navigator.push(context, MaterialPageRoute(builder: (cx)=>WebViewPage(mBloc.historyBean.datas[index].link,mBloc.historyBean.datas[index].title)));
                },
              );
            },itemCount: mBloc.historyBean.datas.length,),
            onRefresh: () async{

              mBloc.historyBean = null;
              mBloc.getWxarticleHistory(mBloc.wxarticleListBean[mSelectNameIndex].id, 1);
            }
            ,
          );
     }
     });
   }

   else{
     return Text('加载中');
   }
  }
  void updateIndex(int index) {
    mSelectNameIndex = index;
    setState(() {

    });
  }
}
  //公众号详细文章
class WxarticleDetailsPage extends StatelessWidget{
  HistoryBean bean;
  WxarticleDetailsPage(this.bean);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Column(
        children: <Widget>[
          Text(
            bean.title,style: TextStyle(fontSize: 18),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(bean.niceDate,textAlign: TextAlign.left,),
          )
        ],
      ),
    );
  }
}
//公众号列表

class WxNameListPage extends StatelessWidget{
  WxarticleListBean mData;
  bool isSelect = false;
  WxNameListPage(this.mData,this.isSelect);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: isSelect?Colors.red:Colors.white)),
      ),
      child: Center(
        child: Text(mData.name),
      ),
    );
  }
}



