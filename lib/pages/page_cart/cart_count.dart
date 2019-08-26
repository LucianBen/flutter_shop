import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/cart.dart';
import 'package:provide/provide.dart';

class CartCount extends StatelessWidget {
  var cartItem;

  CartCount(this.cartItem);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      margin: EdgeInsets.only(top: 5),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Row(
        children: <Widget>[
          _reduceButton(context),
          _countArea(),
          _addButton(context)
        ],
      ),
    );
  }

  //减少按钮
  Widget _reduceButton(context) {
    return InkWell(
      onTap: () {
        Provide.value<CartProvider>(context)
            .addOrReduceGood(cartItem, "reduce");
      },
      child: Container(
        height: ScreenUtil().setWidth(50),
        width: ScreenUtil().setHeight(50),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: cartItem.goodCount > 1 ? Colors.white : Colors.black12,
          border: Border(right: BorderSide(width: 1, color: Colors.black12)),
        ),
        child: Text("—"),
      ),
    );
  }

  //增加按钮
  Widget _addButton(context) {
    return InkWell(
      onTap: () {
        Provide.value<CartProvider>(context).addOrReduceGood(cartItem, "add");
      },
      child: Container(
        height: ScreenUtil().setWidth(50),
        width: ScreenUtil().setHeight(50),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(left: BorderSide(width: 1, color: Colors.black12)),
        ),
        child: Text("+"),
      ),
    );
  }

  //中间数量显示区域
  Widget _countArea() {
    return Container(
      height: ScreenUtil().setHeight(50),
      width: ScreenUtil().setWidth(75),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text("${cartItem.goodCount}"),
    );
  }
}
