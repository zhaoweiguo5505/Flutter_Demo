import 'dart:convert';
import 'dart:core';

import 'package:decimal/decimal.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/Bloc/BlocBase.dart';
import 'package:flutter_demo/Bloc/Home_Bloc.dart';
import 'package:flutter_demo/bean/HomeBannerBean.dart';
import 'package:flutter_demo/bean/HomeCoinBean.dart';
import 'package:flutter_demo/common/BaseCommon.dart';
import 'package:flutter_demo/net/http.dart';
import 'package:flutter_demo/utils/Toast.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeViewState();
  }
}

class HomeViewState extends State<HomeView> {
  final List<ListItem> listData = [];
  ScrollController _scrollController = new ScrollController();
  List<String> _listtitle = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < 20; i++) {
      listData.add(new ListItem("我是测试标题$i", Icons.cake));
    }
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("loadMore");
        getMoreData();
      }
    });
  }

  Future getMoreData() async {}

  Widget HeaderView(Home_Bloc home_bloc) {
    return StreamBuilder(
        stream: home_bloc.bannerStream,
        builder: (BuildContext context, AsyncSnapshot<HomeBannerBean> bean) {
          var homeBannerBean = home_bloc.homeBannerBean;
          if (homeBannerBean == null) {
            return Container(
              height: 200,
              child: Image.asset("buy_vip.png"),
            );
          } else {
            return Container(
              height: 200,
              child: Swiper(
                itemCount: homeBannerBean.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(
                      '${BaseCommon.iamgeUri}${homeBannerBean.data[index].value}');
                },
                onTap: (int index) {
                  Toast.toast(context, '暂时还不能点击噢');
                },
              ),
            );
          }
        });
  }

  Future<Null> listRefresh() async {
    setState(() {
      listData.clear();
      for (int i = 0; i < 20; i++) {
        listData.add(new ListItem("我是刷新出来的$i", Icons.cake));
      }
    });
  }

  Widget _buildLoadText() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Text("加载中……"),
        ),
      ),
      color: Colors.white70,
    );
  }

  /**
   * 加入了controller  用来添加下拉加载，但是有一个bug就是说，如果item没有充满整个屏幕，
   * 下拉加载还是会显示，目前还没有解决方案
   * */
  @override
  Widget build(BuildContext context) {
    Home_Bloc bloc = new Home_Bloc();
    bloc.getData(BaseCommon.homeBanner);
    bloc.getData(BaseCommon.homeCoin);
    return new Scaffold(
      appBar: AppBar(
          title: Text(
            "VBT.CO",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white),
      body: Container(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: <Widget>[
              HeaderView(bloc),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Row(
                  children: <Widget>[Icon(Icons.add_alert), Text('最新的公告')],
                ),
                alignment: Alignment.topLeft,
              ),
              StarCoin(bloc),
              Container(
                height: 100,
                child: Image.asset('images/home_rush.png'),
              ),
              Container(
                height: 100,
                child: Image.asset('images/buy_vip.png'),
              ),
              StreamBuilder(
                stream: bloc.homeCoinStream,
                builder:
                    (BuildContext context, AsyncSnapshot<HomeCoinBean> bean) {
                  if (bloc.homeCoinBean == null) {
                    return Container(
                      child: Text(''),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: bloc.homeCoinBean.dataMap.uSDT.length + 1,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          if (index == bloc.homeCoinBean.dataMap.uSDT.length) {
                            return _buildLoadText();
                          } else {
                            return new ListItemWidget(
                                bloc.homeCoinBean.dataMap.uSDT[index]);
                          }
                        });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget StarCoin(Home_Bloc home_bloc) {
    return StreamBuilder(
        stream: home_bloc.homeCoinStream,
        builder: (BuildContext context, AsyncSnapshot<HomeCoinBean> bean) {
          if (home_bloc.homeCoinBean == null) {
            return Container(
              height: 100,
              child: Text(''),
            );
          } else {
            var homeCoinBean = home_bloc.homeCoinBean;
            return Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              height: 100,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: StarCoinitem(
                        '${homeCoinBean.dataMap.uSDT[0].fnameSn}',
                        '${homeCoinBean.dataMap.uSDT[0].lastDealPrize}',
                        '${homeCoinBean.dataMap.uSDT[0].fupanddown}',
                        '${homeCoinBean.dataMap.uSDT[0].fupanddown}'),
                  ),
                  Expanded(
                    child: StarCoinitem(
                        '${homeCoinBean.dataMap.uSDT[1].fnameSn}',
                        '${homeCoinBean.dataMap.uSDT[1].lastDealPrize}',
                        '${homeCoinBean.dataMap.uSDT[1].fupanddown}',
                        '${homeCoinBean.dataMap.uSDT[1].fupanddown}'),
                  ),
                  Expanded(
                    child: StarCoinitem(
                        '${homeCoinBean.dataMap.uSDT[2].fnameSn}',
                        '${homeCoinBean.dataMap.uSDT[2].lastDealPrize}',
                        '${homeCoinBean.dataMap.uSDT[2].fupanddown}',
                        '${homeCoinBean.dataMap.uSDT[2].fupanddown}'),
                  )
                ],
              ),
            );
          }
        });
  }
}

class StarCoinitem extends StatelessWidget {
  String coinName;
  String coinPrice;
  String coinScal;
  String coinRmb;

  StarCoinitem(this.coinName, this.coinPrice, this.coinRmb, this.coinScal);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Text(coinName),
          ),
          Expanded(
            child: Text(
              coinPrice,
              style: TextStyle(color: Colors.greenAccent, fontSize: 21),
            ),
          ),
          Expanded(
            child: Text(
              coinScal,
              style: TextStyle(color: Colors.greenAccent, fontSize: 15),
            ),
          ),
          Expanded(
            child: Text('=$coinRmb'),
          )
        ],
      ),
    );
  }
}

class ListItem {
  final String title;
  final IconData iconData;

  ListItem(this.title, this.iconData);
}

class ListItemWidget extends StatelessWidget {
  final USDT listItem;

  ListItemWidget(this.listItem);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
      ),
      height: 80,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: GestureDetector(
              child: Image.asset(SpUtil.getInt(listItem.fname, defValue: 0) == 0
                  ? 'coin_fous_normal.png'
                  : 'coin_fous_select.png'),
              onTap: () {
                SpUtil.putInt(listItem.fname,
                    SpUtil.getInt(listItem.fname, defValue: 0) == 0 ? 1 : 0);
              },
            )
            ),
            Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Text(listItem.fnameSn),
                      Text('${listItem.lastDealPrize}')
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  alignment: Alignment.bottomCenter,
                )),
            Expanded(
              flex: 2,
              child: Column(
                children: <Widget>[
                  Text('${listItem.lastDealPrize}'),
                  Text(
                    '${BaseCommon.setScaleRoundDown(Decimal.parse('${listItem.lastDealPrize * 7}'), listItem.priceDecimals)}',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
            Builder(builder: (BuildContext context) {
              return RaisedButton(
                onPressed: () {},
                child: Text(
                  '${listItem.fupanddown}%',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.green,
                highlightColor: Colors.green,
              );
            })
          ],
        ),
      ),
    );
  }
}
