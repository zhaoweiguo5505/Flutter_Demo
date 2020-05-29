


import 'dart:async';
import 'dart:convert';
import 'package:flutter_app/bean/HomeList.dart';
import 'package:flutter_app/bloc/blocBase.dart';
import 'package:flutter_app/common/BaseCommon.dart';
import 'package:flutter_app/http/BaseHttp.dart';
import 'package:flutter_app/ui/home/HomePage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_app/bean/HomeBanner.dart';

import '../bean/ProjectBean.dart';
import '../bean/ProjectTitleBean.dart';
import '../bean/TreeGroupBean.dart';
import '../bean/WxarticleHistoryBean.dart';
import '../bean/WxarticleListBean.dart';

class Homebloc extends BlocBase{
  //首页banner
  BehaviorSubject<List<HomeBanner>> _banner = BehaviorSubject();
   Stream<List<HomeBanner>>  get bannerStream =>_banner.stream;
   Sink<List<HomeBanner>> get bannerSink =>_banner.sink;
  List<HomeBanner> listBanner;

  //首页列表
  BehaviorSubject<Articles> _homeList = BehaviorSubject();
  Stream<Articles>  get ListStream =>_homeList.stream;
  Sink<Articles> get listSink =>_homeList.sink;
  Articles homeList;
  //项目下的文章
  BehaviorSubject<ProjectBean> _behaviorSubject = BehaviorSubject();

  Stream<ProjectBean> get projectStream => _behaviorSubject.stream;

  Sink<ProjectBean>  get projectSink => _behaviorSubject.sink;
  ProjectBean projectBean;
  //项目分类
  BehaviorSubject<List<ProjectTitleBean>> _titleSubject = BehaviorSubject();

  Stream<List<ProjectTitleBean>> get titleStream => _titleSubject.stream;

  Sink<List<ProjectTitleBean>> get titleSink  => _titleSubject.sink;
  List<ProjectTitleBean> titleBean;


  //体系下的数据
  StreamController<List<TreeGroupBean>>  _treeGroup = StreamController();

  Stream<List<TreeGroupBean>> get treeGroupStream => _treeGroup.stream;

  Sink<List<TreeGroupBean>> get _sink => _treeGroup.sink;

  //体系下分类数据
  StreamController<Articles> streamController = StreamController();
  Stream<Articles>  get articleStream => streamController.stream;
  Sink<Articles> get ArticleSink => streamController.sink;

  //微信公众号列表
  BehaviorSubject<List<WxarticleListBean>> _subject = BehaviorSubject();

  Stream<List<WxarticleListBean>> get  wxartpicleStream=> _subject.stream;

  Sink<List<WxarticleListBean>> get wxartpicleSink => _subject.sink;

  List<WxarticleListBean> wxarticleListBean;
  //微信公众号发表文章
  BehaviorSubject<WxarticleHistoryBean> _historysubject = BehaviorSubject();

  Stream<WxarticleHistoryBean> get  historyStream=> _historysubject.stream;

  Sink<WxarticleHistoryBean> get historySink => _historysubject.sink;

  WxarticleHistoryBean historyBean;

  StreamController<Articles> searchController = StreamController();

  Stream<Articles> get searchStream => searchController.stream;

  Sink<Articles> get searchSink => searchController.sink;


  StreamController<ProjectBean> myCollectController = StreamController();

  Stream<ProjectBean>  get myCollectStream => myCollectController.stream;

  Sink<ProjectBean> get myCollectSink =>  myCollectController.sink;
  @override
  void dispose() {

  }

  @override
  void getData(String tag) {
  switch(tag){
    case BaseCommon.HomeBanner:
      _getBanner();
      break;
    case BaseCommon.HomeList:
      _getHomeList();
      break;
    case BaseCommon.projectTitle:
      _getProjectTitle();
      break;
    case BaseCommon.treegroup:
      getTreeGroup();
      break;
  }
  }

  void _getBanner() async{
   var response= await BaseHttp.getInstance().get(BaseCommon.HomeBanner);

    listBanner = response .data.map<HomeBanner>((item) => HomeBanner.fromJson(item))
        .toList();
    _banner.add(listBanner);
  }

  void _getHomeList()  async{
    var response = await BaseHttp.getInstance().get(BaseCommon.HomeList);
      homeList = Articles.fromJson(response.data);
      _homeList.add(homeList);
  }

  void _getProjectTitle() async{
    var response = await BaseHttp.getInstance().get(BaseCommon.projectTitle);
    titleBean =response .data.map<ProjectTitleBean>((item) => ProjectTitleBean.fromJson(item)).toList();
//    _titleSubject.add(titleBean);
    titleSink.add(titleBean);
  }
  void getProjectDetailsData(String tag) async{
    var response = await BaseHttp.getInstance().get(tag);
    projectBean = ProjectBean.fromJson(response.data);
    _behaviorSubject.add(projectBean);
  }

  void getTreeGroup()async {
    var future = await BaseHttp.getInstance().get(BaseCommon.treegroup);
    _sink.add(future.data.map<TreeGroupBean>((item) => TreeGroupBean.fromJson(item)).toList());
  }

  //获取公众号列表

  void getWxartpicleList() async{
    var response = await BaseHttp.getInstance().get(BaseCommon.WxartpicleList);
    wxarticleListBean = response.data.map<WxarticleListBean>((item)=>WxarticleListBean.fromJson(item)).toList();
    _subject.add(wxarticleListBean);
  }

  //获取详细公众号历史发表
  void getWxarticleHistory(int id,int page) async{
    var response = await BaseHttp.getInstance().get('${BaseCommon.WxartpicleHistory}$id/$page/json');
    if(page==1){
      historyBean = WxarticleHistoryBean.fromJson(response.data);
    }
    else{
      historyBean.datas.addAll(WxarticleHistoryBean.fromJson(response.data).datas);
    }
    _historysubject.add(historyBean);
  }

  //体系下分类的数据列表
  void getArticleChild(String url)async{
    var response = await BaseHttp.getInstance().get(url);
    streamController.add(Articles.fromJson(response.data));
  }
  //搜索列表
  void getSearchList(String search,int page) async{
    var response = await BaseHttp.getInstance().post('${BaseCommon.searchList}$page/json',queryParameters:{'k':'android'});
    searchSink.add(Articles.fromJson(response.data));
  }

  void getMyCollectList() async{
    var response = await BaseHttp.getInstance().get(BaseCommon.myCollectList);
    myCollectSink.add(ProjectBean.fromJson(response.data));
  }

}
