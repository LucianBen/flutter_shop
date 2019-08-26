import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/cart.dart';
import 'package:flutter_shop/provide/cart.dart';
import 'package:provide/provide.dart';

import 'cart_count.dart';

class CartItem extends StatelessWidget {
  final CartModel item;

  CartItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.fromLTRB(0, 8, 8, 8),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.black12, width: 1),
          )),
      child: Row(
        children: <Widget>[
          _checkboxButton(context, item),
          _goodImage(item),
          _goodName(item),
          _goodPrice(context, item),
        ],
      ),
    );
  }

  //单选框
  Widget _checkboxButton(context, item) {
    return Container(
      child: Checkbox(
        value: item.isCheck,
        activeColor: Colors.pink,
        onChanged: (bool val) {
          item.isCheck = val;
          Provide.value<CartProvider>(context).changeCheckState(item);
        },
      ),
    );
  }

  //图片
  Widget _goodImage(item) {
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12, width: 1),
      ),
      child: Image.network(item.goodImages),
    );
  }

  //商品名称 & 数量
  Widget _goodName(item) {
    return Container(
      padding: EdgeInsets.all(8),
      width: ScreenUtil().setWidth(320),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(item.goodName, maxLines: 2),
          CartCount(item),
        ],
      ),
    );
  }

  //商品价格 & 删除按钮
  Widget _goodPrice(context, item) {
    return Container(
      width: ScreenUtil().setWidth(150),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            child: Text("￥ ${item.goodPrice}",
                style: TextStyle(fontSize: ScreenUtil().setSp(30))),
          ),
          Container(
            alignment: Alignment.bottomRight,
            margin: EdgeInsets.only(top: 8),
            child: InkWell(
              onTap: () {
                Provide.value<CartProvider>(context)
                    .deleteSingleGood(item.goodId);
              },
              child:
                  Icon(Icons.delete_forever, color: Colors.black26, size: 20),
            ),
          )
        ],
      ),
    );
  }
}
