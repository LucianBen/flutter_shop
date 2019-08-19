import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/router/base_router.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:url_launcher/url_launcher.dart';

import 'hot_goods.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  int page = 1;
  List<Map> hotGoodsList = [];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("百姓生活+"),
      ),
      body: FutureBuilder(
        future: request("homePageContent",
            formData: {'lon': '115.02932', 'lat': '35.76189'}),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //数据处理
            var data = json.decode(snapshot.data.toString());
            List<Map> swiper = (data['data']['slides'] as List).cast();
            List<Map> navigator = (data['data']['category'] as List).cast();
            String adPic = data['data']['advertesPicture']['PICTURE_ADDRESS'];
            String leaderImg = data['data']['shopInfo']['leaderImage'];
            String leaderPhone = data['data']['shopInfo']['leaderPhone'];
            List<Map> recommend = (data['data']['recommend'] as List).cast();
            String floor1Title = data['data']['floor1Pic']['PICTURE_ADDRESS'];
            String floor2Title = data['data']['floor2Pic']['PICTURE_ADDRESS'];
            String floor3Title = data['data']['floor3Pic']['PICTURE_ADDRESS'];
            List<Map> floorContent1 = (data['data']['floor1'] as List).cast();
            List<Map> floorContent2 = (data['data']['floor2'] as List).cast();
            List<Map> floorContent3 = (data['data']['floor3'] as List).cast();
            return EasyRefresh(
              header: ClassicalHeader(
                  bgColor: Colors.pink,
                  textColor: Colors.white,
                  infoColor: Colors.white,
                  infoText: '上次更新时间：%T',
                  refreshText: '下拉加载',
                  refreshedText: '加载中...',
                  refreshReadyText: '放开即加载'),
              footer: ClassicalFooter(
                bgColor: Colors.white,
                textColor: Colors.pink,
                infoColor: Colors.pink,
                loadedText: '上拉加载',
                noMoreText: '',
                infoText: '加载中...',
              ),
              child: ListView(
                children: <Widget>[
                  MySwiper(swiperDataList: swiper),
                  TopNavigator(topNavigatorList: navigator),
                  AdBanner(adPicture: adPic),
                  LeaderPhone(leaderImage: leaderImg, leaderPhone: leaderPhone),
                  Recommend(recommendList: recommend),
                  Floor(floorTitle: floor1Title, floorContent: floorContent1),
                  Floor(floorTitle: floor2Title, floorContent: floorContent2),
                  Floor(floorTitle: floor3Title, floorContent: floorContent3),
                  HotGoods(hotGoodsList),
                ],
              ),
              onLoad: () async {
                print("======== 加载更多 ========="); //获取火爆商品数据
                request('homePageBelowContent', formData: {'page': page})
                    .then((val) {
                  var data = json.decode(val.toString());
                  List<Map> newGoodsList = (data['data'] as List).cast();
                  setState(() {
                    hotGoodsList.addAll(newGoodsList);
                    page++;
                  });
                });
              },
              onRefresh: () async {
                print("====== 刷新 =======");
              },
            );
          } else {
            return Center(
              child: Text("加载中..."),
            );
          }
        },
      ),
    );
  }
}

//首页轮播组件
class MySwiper extends StatelessWidget {
  final List swiperDataList;

  MySwiper({this.swiperDataList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemCount: swiperDataList.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              BaseRouter.router.navigateTo(
                  context, "/detail?id=${swiperDataList[index]['goodsId']}");
            },
            child: Image.network(
              "${swiperDataList[index]['image']}",
              fit: BoxFit.fill,
            ),
          );
        },
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

// 5X2 Gridview 类别导航栏
class TopNavigator extends StatelessWidget {
  final List topNavigatorList;

  TopNavigator({this.topNavigatorList});

  Widget _gridviewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print("点击了导航");
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width: ScreenUtil().setWidth(95),
          ),
          Text(item['mallCategoryName']),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (topNavigatorList.length > 10) {
      topNavigatorList.removeRange(10, topNavigatorList.length);
    }
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3),
      child: GridView.count(
        //屏蔽GridView内部滚动；
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        padding: EdgeInsets.all(5),
        children: topNavigatorList.map((item) {
          return _gridviewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

//广告Banner
class AdBanner extends StatelessWidget {
  final String adPicture;

  AdBanner({this.adPicture});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicture),
    );
  }
}

//店长电话
class LeaderPhone extends StatelessWidget {
  final String leaderPhone;
  final String leaderImage;

  LeaderPhone({this.leaderPhone, this.leaderImage});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _launchURL,
      child: Image.network(leaderImage),
    );
  }

  void _launchURL() async {
    String phoneUrl = "tel:" + leaderPhone;
    if (await canLaunch(phoneUrl)) {
      await launch(phoneUrl);
    } else {
      throw ("$phoneUrl 发生错误");
    }
  }
}

//商品推荐
class Recommend extends StatelessWidget {
  final List recommendList;

  Recommend({this.recommendList});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: ScreenUtil().setHeight(420),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommendList(),
        ],
      ),
    );
  }

  //标题布局
  Widget _titleWidget() {
    return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.black12, width: 0.5)),
        ),
        child: Text(
          "商品推荐",
          style: TextStyle(color: Colors.pink),
        ));
  }

  //单个商品布局
  Widget _item(context, index) {
    return InkWell(
      onTap: () {
        BaseRouter.router.navigateTo(
            context, "/detail?id=${recommendList[index]['goodsId']}");
      },
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(left: BorderSide(color: Colors.black12, width: 0.5)),
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('￥ ${recommendList[index]['mallPrice']}'),
            Text(
              '￥ ${recommendList[index]['price']}',
              style: TextStyle(
                  decoration: TextDecoration.lineThrough, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  //横向列表方法
  Widget _recommendList() {
    return Container(
      height: ScreenUtil().setHeight(350),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context, index) {
          return (_item(context, index));
        },
      ),
    );
  }
}

//楼层
class Floor extends StatelessWidget {
  final String floorTitle;
  final List<Map> floorContent;

  Floor({this.floorTitle, this.floorContent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _FloorTitle(picture_address: floorTitle),
        _FloorContent(context,floorGoodsList: floorContent),
      ],
    );
  }

  //楼层标题
  Widget _FloorTitle({picture_address}) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Image.network(picture_address),
    );
  }

  //楼层商品列表
  Widget _FloorContent(context,{floorGoodsList}) {
    return Container(
      child: Column(
        children: <Widget>[
          //楼层商品列表 第一层
          Row(
            children: <Widget>[
              _goodItem(context,floorGoodsList[0]),
              Column(
                children: <Widget>[
                  _goodItem(context,floorGoodsList[1]),
                  _goodItem(context,floorGoodsList[2]),
                ],
              )
            ],
          ),
          //楼层商品列表 第二层
          Row(
            children: <Widget>[
              _goodItem(context,floorGoodsList[3]),
              _goodItem(context,floorGoodsList[4]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _goodItem(context,Map goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () {
          BaseRouter.router
              .navigateTo(context, "/detail?id=${goods['goodsId']}");
        },
        child: Image.network(goods['image']),
      ),
    );
  }
}
