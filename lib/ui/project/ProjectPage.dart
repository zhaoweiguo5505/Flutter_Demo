import 'package:flutter/material.dart';
import 'package:flutter_app/bean/ProjectBean.dart';
import 'package:flutter_app/bean/ProjectTitleBean.dart';
import 'package:flutter_app/bloc/HomeBloc.dart';
import 'package:flutter_app/common/BaseCommon.dart';
import 'package:flutter_app/common/DemoColor.dart';
import 'package:flutter_app/ui/project/ProjectTabsPage.dart';

//项目
class ProjectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProjectPageState();
  }
}

class ProjectPageState extends State<ProjectPage>
    with TickerProviderStateMixin , AutomaticKeepAliveClientMixin {
  Homebloc projectBloc = Homebloc();

  @override
  Widget build(BuildContext context) {
    projectBloc.getData(BaseCommon.projectTitle);
    return StreamBuilder(
        stream: projectBloc.titleStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data==null) {
            return Center(
              child: Text('加载中')
            );
          } else {
            return getPage(projectBloc.titleBean);
          }
        });
  }

  Widget getPage(List<ProjectTitleBean> titleLIst) {
    TabController tabController;
    tabController = TabController(length: titleLIst.length, vsync: this);
//    print('${tabs.length}长度');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DemoColor.currentColorTheme,
        title: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 25),
              child: TabBar(
                  controller: tabController,
                  indicatorColor: Colors.blue,
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.black,
                  isScrollable: true,
                  tabs: List.generate(
                      titleLIst.length,
                      (index) => Tab(
                            text: titleLIst[index].name,
                          ))),
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: List.generate(
            titleLIst.length, (index) => ProjectTabsPage(titleLIst[index].id)),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
