import 'package:flutter/material.dart';

class ExpansionPanelListView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ExpansionPanelListDemoState();
  }
}

class _ExpansionPanelListDemoState extends State<ExpansionPanelListView> {
  var currentPanelIndex = -1;
  List<int> mList;
  List<ExpandStateBean> expandStateList;
  _ExpansionPanelListDemoState() {
    mList = new List();
    expandStateList=new List();
    for (int i = 0; i < 10; i++) {
      mList.add(i);
      expandStateList.add(ExpandStateBean(i, false));
    }
  }


  _setCurrentIndex(int index,isExpand) {
    setState(() {
      expandStateList.forEach((item){
        if (item.index==index) {
          item.isOpen=!isExpand;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ExpansionPanelList"),
        ),
        body: SingleChildScrollView(child: ExpansionPanelList(
          children: mList.map((index) {
            return new ExpansionPanel(
              headerBuilder: (context, isExpanded) {
                return new ListTile(
                  title: new Text('我是第$index个标题'),
                );
              },
              body: new Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Container(height: 100.0,
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child:Icon(Icons.security,size: 35.0,),),
              ),
              isExpanded: expandStateList[index].isOpen,
            );
          }).toList(),

          expansionCallback: (index, bol) {
            _setCurrentIndex(index,bol);
          },

        ),));
  }
}

class ExpandStateBean{
  var isOpen;
  var index;
  ExpandStateBean(this.index,this.isOpen);
}