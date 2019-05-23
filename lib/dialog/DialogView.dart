import 'package:flutter/material.dart';

class DialogView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DialogViewState();
  }
}

class DialogViewState extends State<DialogView>{
  Widget createDialog(){
    return new CustomizeDialog();
  }

  Widget getAlertDialog(){
    return AlertDialog(
      title: Text("这是一个基础的dialog"),
      content: Text("这是消息"),
      actions: <Widget>[
        FlatButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text("取消")),
        FlatButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text("确定"))
      ],
    );
  }
  Widget getAboutDialog(){
    return new AboutDialog(
      applicationName: '这是名字噢',
      applicationIcon: new Icon(Icons.code),
      applicationVersion: '111111',
      children: <Widget>[
        new Text("这是文本噢")
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
      leading: Icon(Icons.arrow_back_ios),
        centerTitle: true,
        title: Text("dialog"),
      ),
      body: Column(
        children: <Widget>[
        Container(
          child: FlatButton(onPressed: (){
            showDialog(context: context,
                builder: (BuildContext context){
              return getAlertDialog();
            }
            );
          },child: Text("基本对话框")),
        ),
          Container(
            child: FlatButton(onPressed: (){
              showDialog(context: context,
              builder: (BuildContext context){
                return getAboutDialog();
              });
            },
              child: Text("aboutDialog"),
            ),
          ),
        new FlatButton(
          onPressed: (){
            //显示 dialog
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context){
                return createDialog();
              },
            );
          },
          child: new Text("自定义Dialog"),
        ),

        ],
      ),
    );
  }
}
class CustomizeDialog extends Dialog {
  CustomizeDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: const EdgeInsets.all(12.0),
        child: new Material( //创建透明层
          type: MaterialType.transparency, //透明类型(dialog的半透明效果)
          child: new Center( //保证控件居中效果
            child: new SizedBox(
              width: 120.0,
              height: 120.0,
              child: new Container(
                decoration: ShapeDecoration(
                  color: Color(0xffffffff),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                ),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new CircularProgressIndicator(),
                    new Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                      ),
                      child: new Text(
                        "文本内容",
                        style: new TextStyle(fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }

}