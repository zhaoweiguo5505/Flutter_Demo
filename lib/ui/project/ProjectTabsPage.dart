import 'package:flutter/material.dart';
import 'package:flutter_app/bean/ProjectBean.dart';
import 'package:flutter_app/bloc/HomeBloc.dart';
import 'package:flutter_app/bloc/UserCollectBloc.dart';
import 'package:flutter_app/common/BaseCommon.dart';
import 'package:flutter_app/utils/my_card.dart';

import '../WebViewPage.dart';

//项目
class ProjectTabsPage extends StatefulWidget {
  int id;

  ProjectTabsPage(this.id);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProjectTabsPageState(id);
  }
}

class ProjectTabsPageState extends State<ProjectTabsPage> {
  int id;

  ProjectTabsPageState(this.id);

  Homebloc projectBloc = Homebloc();

  @override
  Widget build(BuildContext context) {
    projectBloc.getProjectDetailsData('${BaseCommon.ProjectList}$id');
    return Scaffold(
      body: StreamBuilder(
          stream: projectBloc.projectStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (projectBloc.projectBean == null) {
              return Center(
                child: Text('加载中'),
              );
            } else {
              return  ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return  ProjectListWidget(projectBloc.projectBean.datas[index]);
                  },
                  shrinkWrap: true,
                  itemCount: projectBloc.projectBean.datas.length,
                );
            }
          }),
    );
  }
}

class ProjectListWidget extends StatefulWidget{
  Projectdata projectdata;
  ProjectListWidget(this.projectdata);
  @override
  State<StatefulWidget> createState() {
    return ProjectListState(projectdata);
  }
}
class ProjectListState extends State<ProjectListWidget> {
  Projectdata projectdata;
  ProjectListState(this.projectdata);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MyCard(
      width: 120,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),

      height: 100,
      child: Row(
        children: <Widget>[
          Expanded(
              child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  height: 90,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          projectdata.title,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          textAlign: TextAlign.left,
                        ),
                      )),
                      Expanded(
                          child: Container(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          children: <Widget>[
                            Text(
                              '时间：${projectdata.niceShareDate}',
                              style: TextStyle(fontSize: 12),
                            ),
                            Expanded(
                                child: Text(
                              '作者：${projectdata.superChapterName}',
                              textAlign: TextAlign.right,
                              style: TextStyle(fontSize: 12),
                            )), Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: GestureDetector(
                                    child:  Icon(
                                      UserCollectBloc.isCollect(projectdata.id)?Icons.favorite:Icons.favorite_border,
                                      color: Colors.red,

                                    ),
                                    onTap: (){
                                      addCollect(projectdata.id, context);
                                    },
                                  ),
                              ),

                          ],
                        ),
                      ))
                    ],
                  ))
            ],
          )),
          Container(
            width: 80,
            child: Image.network(projectdata.envelopePic),
          )
        ],
      ),
    );

  }
  /**
   * 收藏调用接口
   * */
  void addCollect(int id, BuildContext context) async {
    await UserCollectBloc.addAndDeleteCollect(id, context);
    setState(() {
    });
  }
}
