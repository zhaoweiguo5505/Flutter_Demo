import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/mine/LoginPage.dart';

class BaseCommon {
  static const String HomeBanner = 'banner/json'; //首页banner
  static const String HomeList = 'article/list/1/json'; //公众号详细资料
  static const String ProjectList = 'project/list/1/json?cid='; //项目详细列表
  static const String projectTitle = 'project/tree/json'; //项目分类
  static const String WxartpicleList = 'wxarticle/chapters/json'; //微信公众号
  static const String WxartpicleHistory = 'wxarticle/list/'; //微信公众号名称列表
  static const String Register = "user/register"; //注册
  static const String Login = "user/login"; //登陆
  static const String Logout = "user/logout/json"; //推出登陆
  static const String user = 'User'; //存储user信息
  static const String addCollect = 'lg/collect/'; //添加收藏列表
  static const String userCollect = 'lg/collect/list/'; //我的收藏列表
  static const String deleteCollect = 'lg/uncollect_originId/'; //取消收藏
  static const String treegroup = 'tree/json'; //体系
  static const String articleList = 'article/list/';//体系详细列表
  static const String searchList = 'article/query/';//搜索页面查询
  static const String myCollectList = 'lg/collect/list/0/json';
  static BaseCommon _baseCommon;
  static BaseCommon getInstanse(){
    if(_baseCommon==null){
        _baseCommon = BaseCommon();
    }

    return _baseCommon;
  }
  //跳转页面
  void pop(BuildContext context,Widget widget){
    Navigator.push(context, MaterialPageRoute(builder: (cx)=>widget));
  }
}
