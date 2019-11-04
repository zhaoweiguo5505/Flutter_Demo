

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/bloc/blocBase.dart';
import 'package:flutter_app/common/BaseCommon.dart';
import 'package:flutter_app/http/BaseHttp.dart';
import 'package:flutter_app/utils/Toast.dart';

class UserCollectBloc {
    //全局为了比对是否收藏文章
  static Map<int,bool> collectMap = Map();

  static  addAndDeleteCollect(int id,BuildContext context) async{
    if(isCollect(id)){
      try {
        var post = await BaseHttp.getInstance().post('${BaseCommon.deleteCollect}$id/json');
        Toast.toast(context, '取消收藏');
        collectMap.remove(id);
      } catch (e) {
        Toast.toast(context, BaseHttp.errorMessage);
      }
    }
    else{
      try {
        var post = await BaseHttp.getInstance().post('${BaseCommon.addCollect}$id/json');
        print('收藏成功');
        Toast.toast(context, '收藏成功');
        collectMap[id] = true;
      } catch (e) {
        Toast.toast(context, BaseHttp.errorMessage);
      }
    }
  }

  //比对一下是否添加
 static bool isCollect(int id){
    return collectMap.containsKey(id);
 }
}