

import 'package:flutter/material.dart';
import 'package:flutter_app/common/BaseColors.dart';
import 'package:flutter_app/common/DemoColor.dart';

class AnimationPage extends StatefulWidget {
  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>  with SingleTickerProviderStateMixin{

  Animation animation;
  AnimationController _animationController;
  double animationValue;
  AnimationStatus animationState;
  Color colors = Colors.blue;
  Animation<double> animationSize;
  double contaionHeight = 100;
  Animation<Color> animationColor;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationController = AnimationController(duration: Duration(seconds: 5),vsync: this);
    animation = CurvedAnimation(parent: _animationController, curve: Curves.elasticInOut);
    animationColor = ColorTween(begin: Colors.green,end: Colors.blue).animate(animation)
    ..addListener((){
        setState(() {
        });
    });

//    animationSize = Tween<double>(begin: 0, end: 300).animate(_animationController)
//      ..addListener(() {
//        // #enddocregion addListener
//        setState(() {
//          animationValue = animation.value;
//        });
//        // #docregion addListener
//      })
//      ..addStatusListener((AnimationStatus state) {
//        setState(() {
//          if(state==AnimationStatus.completed){
//            _animationController.reverse();
//          }
//          else if (state==AnimationStatus.dismissed){
//            _animationController.forward();
//          }
//        });
//      });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DemoColor.currentColorTheme,
        title: Text('动画学习'),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
          Navigator.pop(context);
        }),
      ),
      body: Column(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.input,size: 50),
            onPressed: (){
              setState(() {
                  _animationController.forward();
              });
            },
          ),
          Container(
                height: 200,
                width:200,
                color: animationColor.value,
                child: Text('测试一下'),
              ),
        ],
      ),
    );
  }
}
