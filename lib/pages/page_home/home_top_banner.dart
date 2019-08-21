import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/router/base_router.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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
