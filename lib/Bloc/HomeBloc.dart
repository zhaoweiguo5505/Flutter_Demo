


import 'dart:convert';
import 'package:flutter_app/bean/HomeList.dart';
import 'package:flutter_app/bloc/blocBase.dart';
import 'package:flutter_app/common/BaseCommon.dart';
import 'package:flutter_app/http/BaseHttp.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_app/bean/HomeBanner.dart';

class Homebloc extends BlocBase{
  BehaviorSubject<List<HomeBanner>> _banner = BehaviorSubject();
   Stream<List<HomeBanner>>  get bannerStream =>_banner.stream;
   Sink<List<HomeBanner>> get bannerSink =>_banner.sink;
  List<HomeBanner> listBanner;


  BehaviorSubject<Articles> _homeList = BehaviorSubject();
  Stream<Articles>  get ListStream =>_homeList.stream;
  Sink<Articles> get listSink =>_homeList.sink;
  Articles homeList;
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

}
