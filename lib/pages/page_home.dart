import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("百姓生活+"),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: request("homePageContent",
              formData: {'lon': '115.02932', 'lat': '35.76189'}),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //数据处理
              var data = json.decode(snapshot.data.toString());
              List<Map> swiper = (data['data']['slides'] as List).cast();
              List<Map> navigator = (data['data']['category'] as List).cast();

              return Column(
                children: <Widget>[
                  MySwiper(swiperDataList: swiper),
                  TopNavigator(navigator),
                ],
              );
            } else {
              return Center(
                child: Text("加载中..."),
              );
            }
          },
        ),
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
          return Image.network(
            "${swiperDataList[index]['image']}",
            fit: BoxFit.fill,
          );
        },
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

// 5X2 导航栏
class TopNavigator extends StatelessWidget {
  final List topNavigatorList;

  TopNavigator(this.topNavigatorList);

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
      height: ScreenUtil().setHeight(350),
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
