import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/cart.dart';
import 'package:provide/provide.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(132),
      padding: EdgeInsets.all(8),
      color: Colors.white,
      child: Provide<CartProvider>(
        builder: (context, child, val) {
          double allGoodsPrice =
              Provide.value<CartProvider>(context).allGoodsPrice;
          int allGoodsCount =
              Provide.value<CartProvider>(context).allGoodsCount;
          return Row(
            children: <Widget>[
              _selectAllButton(context),
              _allPrice(allGoodsPrice),
              _payButton(allGoodsCount),
            ],
          );
        },
      ),
    );
  }

  //全选勾选框
  Widget _selectAllButton(context) {
    return Row(
      children: <Widget>[
        Checkbox(
          value: Provide.value<CartProvider>(context).isAllCheck,
          activeColor: Colors.pink,
          onChanged: (val) {
            Provide.value<CartProvider>(context).changeAllCheckBtnState(val);
          },
        ),
        Text("全选")
      ],
    );
  }

  //付款按钮
  Widget _allPrice(allPrice) {
    return Container(
      width: ScreenUtil().setWidth(410),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                child: Text("合计：",
                    style: TextStyle(fontSize: ScreenUtil().setSp(35))),
              ),
              Container(
                child: Text(
                  "$allPrice 元",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(36), color: Colors.red),
                ),
              )
            ],
          ),
          Container(
            width: ScreenUtil().setWidth(410),
            alignment: Alignment.centerRight,
            child: Text("满10元免配送费，预购免配送费",
                style: TextStyle(
                    color: Colors.black38, fontSize: ScreenUtil().setSp(22))),
          )
        ],
      ),
    );
  }

//付款按钮
  Widget _payButton(int count) {
    return Container(
      padding: EdgeInsets.only(left: 15, top: 5, right: 10, bottom: 5),
      width: ScreenUtil().setWidth(180),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(3.0)),
          child: Text("付款 ($count)", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
