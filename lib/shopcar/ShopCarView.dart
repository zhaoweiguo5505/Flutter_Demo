import 'package:flutter/material.dart';

class ShopCarView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ShopCarViewState();
  }
}

class ShopCarViewState extends State<ShopCarView>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("购物车"),backgroundColor: Colors.blue),
    );
  }
}