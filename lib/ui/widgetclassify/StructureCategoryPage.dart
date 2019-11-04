

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bean/TreeGroupBean.dart';
import 'package:flutter_app/bloc/WidgetBloc.dart';
import 'package:flutter_app/common/BaseCommon.dart';
import 'package:flutter_app/ui/widgetclassify/ChildrenPage.dart';

class StructureCategoryPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StructureCategoryPageState();
  }
}
class StructureCategoryPageState extends State<StructureCategoryPage>{
  @override
  Widget build(BuildContext context) {
    WidgetBloc bloc = WidgetBloc();
    bloc.getData(BaseCommon.treegroup);
    return Scaffold(
      appBar: AppBar(
        title: Text('体系'),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: bloc.treeGroupStream,
          builder: (BuildContext context,AsyncSnapshot<List<TreeGroupBean>> shot){
            if(shot.data!=null){
              return ListView.builder(itemBuilder: (BuildContext context,int index){
                return ChildrenPage(shot.data[index]);
              },itemCount: shot.data.length,);
            }
            else{
              return Center(
                child: Text('加载中'),
              );
            }
          }),
    );
  }
}

