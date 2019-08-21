import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_shop/pages/page_home/home_goods_hot.dart';
import 'package:flutter_shop/service/service_method.dart';

import 'page_home/home_goods_floor.dart';
import 'page_home/home_goods_recommend.dart';
import 'page_home/home_gridview.dart';
import 'page_home/home_middle_area.dart';
import 'page_home/home_top_banner.dart';

/**
 *   首页
 * */
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
