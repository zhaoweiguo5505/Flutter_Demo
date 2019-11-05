

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bean/TreeGroupBean.dart';
import 'package:flutter_app/bloc/HomeBloc.dart';
import 'package:flutter_app/common/BaseCommon.dart';
import 'package:flutter_app/ui/widgetclassify/ArticleChildPage.dart';

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
    Homebloc bloc = Homebloc();
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
class ChildrenPage extends StatefulWidget{
  TreeGroupBean treeChildren;
  ChildrenPage(this.treeChildren);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChildrenPageState(treeChildren);
  }
}

class ChildrenPageState extends State<ChildrenPage>{
  TreeGroupBean tree;
  ChildrenPageState(this.tree);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            tree.name,
          ),
          Wrap(
              spacing: 10,
              children: List.generate(
                  tree.children.length,
                      (index) => ActionChip(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (cx) => ArticleChildPage(tree.children[index].id,tree.children[index].name)));
                    },
                    label: Text(
                      tree.children[index].name,
                      maxLines: 1,
                    ),
                  )))
        ],
      ),
    );
  }
}
