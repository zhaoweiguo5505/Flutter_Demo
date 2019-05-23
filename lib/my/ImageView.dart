import 'package:flutter/material.dart';

class ImageView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ImageViewState();
}

class ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title:Text("图片加载"),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed:(){
          Navigator.of(context).pop();
        }),
        centerTitle: true,
      ),
      body:ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.amberAccent,
            child: Container(
              child: Text("加载本地图片   Image.asset(images/your_is_didi.jpg)   加载本地图片需要在 pubspec.yaml 文件中 flutter节点下 添加    assets: - images/your_is_didi.jpg"
                  "由于我是只有一张图片，所以我直接写了一张，多张图片直接加 - images  注意 在-符号和iamges中 有一个空格，没有空格的话 会导致加载失败，找不到文件，iamges文件夹与lib同级",
                style: TextStyle(backgroundColor: Colors.white),
              ),
                color: Colors.white,
            )

          ),
          Container(
            child: Image.asset("images/your_is_didi.jpg"),
          ),
          Container(
              padding: EdgeInsets.all(10),
              color: Colors.amberAccent,
              child: Container(
                child:Text("加载网络图片   Image.network(https://binting.oss-cn-shanghai.aliyuncs.com/other/Adv/20190515172257_86415.png),"),
                color: Colors.white,
              )
          ),
          Container(
            child: Image.network("https://binting.oss-cn-shanghai.aliyuncs.com/other/Adv/20190515172257_86415.png"),
          )
        ],
      ),
    );
  }
}