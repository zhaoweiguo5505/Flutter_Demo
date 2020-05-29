

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/DemoColor.dart';

class BaseColors extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return BaseColorsState();
  }

}
class  BaseColorsState extends State<BaseColors>{
  List<Color> colors = DemoColor.supportColors;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('设置主题颜色'),
        backgroundColor: DemoColor.currentColorTheme,
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed:(){
          Navigator.pop(context);
        },),
      ),
      body:  Padding(
          padding: const EdgeInsets.all(4.0),
          child: GridView.count(
            crossAxisCount: 4,
            children: List.generate(colors.length, (index) {
              return InkWell(
                onTap: () {
                  DemoColor.currentColorTheme = colors[index];
                  setState(() {

                  });
//                  DemoColor.setColorTheme(index);
//                  changeColorTheme(colors[index]);
                },
                child: Container(
                  color: colors[index],
                  margin: const EdgeInsets.all(3.0),
                ),
              );
            }),
          )
      )
    );
  }
}