

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bean/User.dart';
import 'package:flutter_app/bloc/UserCollectBloc.dart';
import 'package:flutter_app/common/BaseCommon.dart';
import 'package:flutter_app/http/BaseHttp.dart';
import 'package:flutter_app/ui/mine/LoginPage.dart';

class MinePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MinePageState();
  }
}

class MinePageState extends State<MinePage>{
  List<MineListData>  listData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      listData = List();
      listData.add(MineListData('收藏', Icon(Icons.favorite_border)));
      listData.add(MineListData('设置', Icon(Icons.settings)));
      listData.add(MineListData('主题颜色', Icon(Icons.color_lens)));
      listData.add(MineListData('退出登录', Icon(Icons.exit_to_app)));
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: ListView.builder(itemBuilder: (BuildContext context,int index){
        if(index==0){
          return CreateHeaderPage();
        }
        return MineListItemWidget(listData[index-1]);
      },itemCount: listData.length+1)
    );
  }

  Widget CreateHeaderPage() {
    var item = StorageManager.localStorage.getItem(BaseCommon.user);
    return Container(
      height: 200,
      child: GestureDetector(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.person,size: 40,),
            Text(item==null?"未登录":item['nickname'])
          ],
        ),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (cx)=>LoginPage()));
        },
      ),
      decoration: BoxDecoration(
        color: Colors.green
      ),
    );
  }
}

class MineListData{
  Icon  _icon;
  String message;
MineListData(this.message,this._icon);
}
class MineListItemWidget extends StatefulWidget{
  MineListData data;
  MineListItemWidget(this.data);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MineListItem(data);
  }
}
class MineListItem extends State{
  MineListData data;
  MineListItem(this.data);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.white30))
      ),
      height: 50,
      child: GestureDetector(
        child: Row(
          children: <Widget>[
            Expanded(
              child: data._icon,
            ),
            Expanded(child: Text(data.message),flex: 3,)
          ],
        ),
        onTap: (){
          if(data.message=='退出登录'){
           logOut();
          }
        },
      ),
    );
  }

  void logOut() async{
    await http.get('user/logout/json');
    StorageManager.localStorage.deleteItem(BaseCommon.user);
    UserCollectBloc.collectMap.clear();
    setState(() {

    });
  }
}