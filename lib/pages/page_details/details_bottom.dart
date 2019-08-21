import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/cart.dart';
import 'package:flutter_shop/provide/details_good.dart';
import 'package:provide/provide.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsInfo =
        Provide.value<DetailsGoodProvider>(context).goodInfo.data.goodInfo;
    var goodId = goodsInfo.goodsId;
    var goodName = goodsInfo.goodsName;
    var goodCount = 1;
    var goodPrice = goodsInfo.presentPrice;
    var goodImages = goodsInfo.image1;
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(100),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: Container(
              width: ScreenUtil().setWidth(110),
              alignment: Alignment.center,
              child: Icon(
                Icons.shopping_cart,
                size: 35,
                color: Colors.red,
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              await Provide.value<CartProvider>(context)
                  .save(goodId, goodName, goodCount, goodPrice, goodImages);
            },
            child: Container(
              color: Colors.green,
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(100),
              alignment: Alignment.center,
              child: Text("加入购物车",
                  style: TextStyle(
                      color: Colors.white, fontSize: ScreenUtil().setSp(28))),
            ),
          ),
          InkWell(
            onTap: () async {
              await Provide.value<CartProvider>(context).remove();
            },
            child: Container(
              color: Colors.red,
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(100),
              alignment: Alignment.center,
              child: Text("立即购买",
                  style: TextStyle(
                      color: Colors.white, fontSize: ScreenUtil().setSp(28))),
            ),
          ),
        ],
      ),
    );
  }
}
