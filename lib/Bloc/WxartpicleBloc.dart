

import 'package:flutter_app/bean/WxarticleHistoryBean.dart';
import 'package:flutter_app/bean/WxarticleListBean.dart';
import 'package:flutter_app/bloc/blocBase.dart';
import 'package:flutter_app/common/BaseCommon.dart';
import 'package:flutter_app/http/BaseHttp.dart';
import 'package:rxdart/rxdart.dart';

class WxartpicleBloc extends BlocBase{
  BehaviorSubject<List<WxarticleListBean>> _subject = BehaviorSubject();

  Stream<List<WxarticleListBean>> get  wxartpicleStream=> _subject.stream;

  Sink<List<WxarticleListBean>> get wxartpicleSink => _subject.sink;

  List<WxarticleListBean> wxarticleListBean;

  BehaviorSubject<WxarticleHistoryBean> _historysubject = BehaviorSubject();

  Stream<WxarticleHistoryBean> get  historyStream=> _historysubject.stream;

  Sink<WxarticleHistoryBean> get historySink => _historysubject.sink;

  WxarticleHistoryBean historyBean;

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void getData(String tag) {
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
}