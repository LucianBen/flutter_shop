import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/config/service_url.dart';
import 'package:flutter_shop/model/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  var cartString = "[]";
  List<CartModel> cartList = [];

  save(goodId, goodName, goodCount, goodPrice, goodImages) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString(CART_INFO);

    var temp = cartString == null ? [] : json.decode(cartString);
    List<Map> tempList = (temp as List).cast();
    int ival = 0;
    bool isHave = false;

    tempList.forEach((item) {
      if (item['goodId'] == goodId) {
        tempList[ival]['goodCount'] = item['goodCount'] + 1;
        cartList[ival].goodCount++;
        isHave = true;
      }
      ival++;
    });

    if (!isHave) {
      Map<String, dynamic> newGood = {
        "goodId": goodId,
        "goodName": goodName,
        "goodCount": goodCount,
        "goodPrice": goodPrice,
        "goodImages": goodImages,
        "isCheck": true,
      };

      tempList.add(newGood);
      cartList.add(CartModel.fromJson(newGood));
    }
    cartString = json.encode(tempList).toString();
    prefs.setString(CART_INFO, cartString);
    notifyListeners();

    print(cartString);
    print("=========$cartList");
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(CART_INFO);
    cartList = [];
    notifyListeners();

    print("清空完成--------------");
  }

  getCartData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString(CART_INFO);
    cartList = [];

    if (cartString != null) {
      List<Map> tempList = (json.decode(cartString) as List).cast();
      tempList.forEach((item) {
        cartList.add(CartModel.fromJson(item));
      });
    }

    notifyListeners();
  }
}
