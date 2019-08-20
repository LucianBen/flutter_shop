import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/details_good.dart';
import 'package:provide/provide.dart';

class DetailsTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsGoodProvider>(
      builder: (context, child, val) {
        var goodInfo =
            Provide.value<DetailsGoodProvider>(context).goodInfo.data.goodInfo;
        if (goodInfo != null) {
          return Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                _goodImage(goodInfo.image1),
                _goodName(goodInfo.goodsName),
                _goodNumber(goodInfo.goodsSerialNumber),
                _goodPrice(goodInfo.presentPrice, goodInfo.oriPrice),
              ],
            ),
          );
        } else {
          return Text("正在加载中...");
        }
      },
    );
  }

  //商品图片
  Widget _goodImage(url) {
    return Image.network(
      url,
      width: ScreenUtil().setWidth(740),
    );
  }

  //商品标题和编号
  Widget _goodName(name) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      width: ScreenUtil().setWidth(740),
      child: Text(
        name,
        style: TextStyle(fontSize: ScreenUtil().setSp(30)),
      ),
    );
  }

  //商品的价格
  Widget _goodNumber(number) {
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 10, top: 5, bottom: 8),
      child: Text(
        "编号：$number",
        style: TextStyle(color: Colors.black12),
      ),
    );
  }

  //商品的价格
  Widget _goodPrice(price, marketPrice) {
    return Container(
      margin: EdgeInsets.only(left: 10, bottom: 10),
      alignment: Alignment.bottomLeft,
      child: Row(
        children: <Widget>[
          Text(
            "￥ $price",
            style:
                TextStyle(color: Colors.red, fontSize: ScreenUtil().setSp(40)),
          ),
          Text("                市场价："),
          Text(
            "￥ $marketPrice",
            style: TextStyle(
                color: Colors.black26, decoration: TextDecoration.lineThrough),
          ),
        ],
      ),
    );
  }
}
