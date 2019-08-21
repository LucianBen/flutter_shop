import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/router/base_router.dart';

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
        _FloorContent(context, floorGoodsList: floorContent),
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
  Widget _FloorContent(context, {floorGoodsList}) {
    return Container(
      child: Column(
        children: <Widget>[
          //楼层商品列表 第一层
          Row(
            children: <Widget>[
              _goodItem(context, floorGoodsList[0]),
              Column(
                children: <Widget>[
                  _goodItem(context, floorGoodsList[1]),
                  _goodItem(context, floorGoodsList[2]),
                ],
              )
            ],
          ),
          //楼层商品列表 第二层
          Row(
            children: <Widget>[
              _goodItem(context, floorGoodsList[3]),
              _goodItem(context, floorGoodsList[4]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _goodItem(context, Map goods) {
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
