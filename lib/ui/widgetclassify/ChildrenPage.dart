


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bean/TreeGroupBean.dart';

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