import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/config/service_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  var cartString = "[]";

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
        isHave = true;
      }
      ival++;
    });

    if (!isHave) {
      tempList.add({
        "goodId": goodId,
        "goodName": goodName,
        "goodCount": goodCount,
        "goodPrice": goodPrice,
        "goodImages": goodImages
      });
    }
    cartString = json.encode(tempList).toString();
    prefs.setString(CART_INFO, cartString);
    notifyListeners();

    print(cartString);
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(CART_INFO);
    notifyListeners();

    print("清空完成--------------");
  }
}
