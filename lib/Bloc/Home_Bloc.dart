import 'dart:convert';

import 'package:flutter_demo/Bloc/BlocBase.dart';
import 'package:flutter_demo/bean/HomeBannerBean.dart';
import 'package:flutter_demo/bean/HomeCoinBean.dart';
import 'package:flutter_demo/common/BaseCommon.dart';
import 'package:flutter_demo/net/http.dart';
import 'package:rxdart/rxdart.dart';

class Home_Bloc implements BlocBase {
  BehaviorSubject<HomeBannerBean> banner = BehaviorSubject<HomeBannerBean>();

  Sink<HomeBannerBean> get bannerSink => banner.sink;

  Stream<HomeBannerBean> get bannerStream => banner.stream;

  HomeBannerBean homeBannerBean;

  BehaviorSubject<HomeCoinBean> homeCoin = BehaviorSubject<HomeCoinBean>();

  Sink<HomeCoinBean> get homeCoinSink => homeCoin.sink;

  Stream<HomeCoinBean> get homeCoinStream => homeCoin.stream;

  HomeCoinBean homeCoinBean;

  @override
  void dispose() {}

  @override
  void getData(String tag) {
    switch (tag) {
      case BaseCommon.homeBanner:
        getHomeBannerData();
        break;
      case BaseCommon.homeCoin:
        getHomeCoin();
        break;
    }
  }

  void getHomeBannerData() async {
    var _bannerData = await Http.getInstance().get('v1/image');
    var decode = json.decode(_bannerData);
//    print(_bannerData);
    homeBannerBean = HomeBannerBean.fromJson(decode);
    bannerSink.add(homeBannerBean);
  }

  void getHomeCoin() async {
    var _coinData = await Http.getInstance().get('v2/market/coins');
    homeCoinBean = HomeCoinBean.fromJson(json.decode(_coinData));
    homeCoinSink.add(homeCoinBean);
    print(_coinData);
  }
}
