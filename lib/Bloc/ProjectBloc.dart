

import 'package:flutter_app/bean/ProjectBean.dart';
import 'package:flutter_app/bean/ProjectTitleBean.dart';
import 'package:flutter_app/bloc/blocBase.dart';
import 'package:flutter_app/common/BaseCommon.dart';
import 'package:flutter_app/http/BaseHttp.dart';
import 'package:rxdart/rxdart.dart';

class ProjectBloc extends BlocBase{
  BehaviorSubject<ProjectBean> _behaviorSubject = BehaviorSubject();

  Stream<ProjectBean> get projectStream => _behaviorSubject.stream;

  Sink<ProjectBean>  get projectSink => _behaviorSubject.sink;
  ProjectBean projectBean;
  //项目分类
  BehaviorSubject<List<ProjectTitleBean>> _titleSubject = BehaviorSubject();

  Stream<List<ProjectTitleBean>> get titleStream => _titleSubject.stream;

  Sink<List<ProjectTitleBean>> get titleSink  => _titleSubject.sink;
  List<ProjectTitleBean> titleBean;
  @override
  void dispose() {

  }

  @override
  void getData(String tag)  async{
    switch (tag){
      case BaseCommon.projectTitle:
        var response = await BaseHttp.getInstance().get(tag);
        titleBean =response .data.map<ProjectTitleBean>((item) => ProjectTitleBean.fromJson(item)).toList();
        _titleSubject.add(titleBean);
        break;
    }
  }
  void getProjectDetailsData(String tag) async{
    var response = await BaseHttp.getInstance().get(tag);
    projectBean = ProjectBean.fromJson(response.data);
    _behaviorSubject.add(projectBean);
  }

}