import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/config/service_url.dart';
import 'package:flutter_shop/model/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  var cartString = "[]";
  List<CartModel> cartList = [];

  double allGoodsPrice = 0.0; //总价格
  int allGoodsCount = 0; //商品总数量

  bool isAllCheck = true; //是否全选

  /* 保存商品 */
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

  /*清空购物车*/
  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(CART_INFO);
    cartList = [];
    notifyListeners();

    print("清空完成--------------");
  }

  /*获取购物车商品数据*/
  getCartData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString(CART_INFO);
    cartList = [];

    if (cartString != null) {
      List<Map> tempList = (json.decode(cartString) as List).cast();
      allGoodsPrice = 0.0;
      allGoodsCount = 0;
      isAllCheck = true;

      tempList.forEach((item) {
        if (item['isCheck']) {
          allGoodsPrice += (item['goodCount'] * item['goodPrice']);
          allGoodsCount += item['goodCount'];
        } else {
          isAllCheck = false;
        }

        cartList.add(CartModel.fromJson(item));
      });
    }

    notifyListeners();
  }

  /*删除单个购物车商品*/
  deleteSingleGood(String goodId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString(CART_INFO);
    List<Map> listTemp = (json.decode(cartString) as List).cast();
    int currentIndex = 0;
    int deleteIndex = 0;

    listTemp.forEach((item) {
      if (item['goodId'] == goodId) {
        deleteIndex = currentIndex;
      }
      currentIndex++;
    });

    listTemp.removeAt(deleteIndex);
    cartString = json.encode(listTemp).toString();
    prefs.setString(CART_INFO, cartString);
    await getCartData();
  }

  /*改变CheckBox*/
  changeCheckState(CartModel cartModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString(CART_INFO);
    int currentIndex = 0;
    int changeIndex = 0;

    List<Map> listTemp = (json.decode(cartString) as List).cast();
    listTemp.forEach((item) {
      if (item['goodId'] == cartModel.goodId) {
        changeIndex = currentIndex;
      }
      currentIndex++;
    });

    listTemp[changeIndex] = cartModel.toJson(); //把对象变成Map值
    cartString = json.encode(listTemp).toString(); //变成字符串
    prefs.setString(CART_INFO, cartString); //进行持久化
    await getCartData();
  }

  /*点击全选按钮*/
  changeAllCheckBtnState(bool isCheck) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString(CART_INFO);
    List<Map> listTemp = (json.decode(cartString) as List).cast();
    List<Map> newList = []; //新建一个List，用于组成新的持久化数据。

    for (var item in listTemp) {
      var newItem = item;
      newItem['isCheck'] = isCheck;
      newList.add(newItem);
    }

    cartString = json.encode(newList).toString();
    prefs.setString(CART_INFO, cartString);
    await getCartData();
  }

/*商品数量加减*/
  addOrReduceGood(var cartItem, String todo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString(CART_INFO);
    List<Map> listTemp = (json.decode(cartString) as List).cast();
    int currentIndex = 0;
    int changeIndex = 0;

    listTemp.forEach((item) {
      if (item['goodId'] == cartItem.goodId) {
        changeIndex = currentIndex;
      }
      currentIndex++;
    });

    if (todo == "add") {
      cartItem.goodCount++;
    } else if (cartItem.goodCount > 1) {
      cartItem.goodCount--;
    }
    listTemp[changeIndex] = cartItem.toJson();

    cartString = json.encode(listTemp).toString();
    prefs.setString(CART_INFO, cartString);
    await getCartData();
  }
}
