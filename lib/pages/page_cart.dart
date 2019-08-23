import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/cart.dart';
import 'package:provide/provide.dart';

import 'page_cart/cart_bottom.dart';
import 'page_cart/cart_item.dart';

/**
 *   购物车
 * */

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("购物车"),
      ),
      body: FutureBuilder(
          future: _getCartData(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List cartList = Provide.value<CartProvider>(context).cartList;

              return Stack(children: <Widget>[
                Positioned(
                  height: ScreenUtil().setHeight(920),
                  width:  ScreenUtil().setWidth(750),
                  child: ListView.builder(
                    itemCount: cartList.length,
                    itemBuilder: (context, index) {
                      return CartItem(cartList[index]);
                    },
                  ),
                ),
                Positioned(left: 0.0, bottom: 0.0, child: CartBottom())
              ]);
            } else {
              return Text("正在加载中...");
            }
          }),
    );
  }

  Future<String> _getCartData(BuildContext context) async {
    await Provide.value<CartProvider>(context).getCartData();
    return 'end';
  }
}
