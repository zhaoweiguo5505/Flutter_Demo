


import 'dart:async';

import 'package:flutter_app/bean/TreeGroupBean.dart';
import 'package:flutter_app/bloc/blocBase.dart';
import 'package:flutter_app/common/BaseCommon.dart';
import 'package:flutter_app/http/BaseHttp.dart';
import 'package:rxdart/rxdart.dart';

class WidgetBloc extends BlocBase{
  StreamController<List<TreeGroupBean>>  _treeGroup = StreamController();

  Stream<List<TreeGroupBean>> get treeGroupStream => _treeGroup.stream;

  Sink<List<TreeGroupBean>> get _sink => _treeGroup.sink;
  @override
  void dispose() {
    _treeGroup = null;
  }

  @override
  void getData(String tag) async{
    switch(tag){
      case BaseCommon.treegroup:
          var future = await BaseHttp.getInstance().get(tag);
          _sink.add(future.data.map<TreeGroupBean>((item) => TreeGroupBean.fromJson(item)).toList());
        break;
    }
  }
}