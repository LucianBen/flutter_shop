import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category_goods.dart';

class CategoryChildGood with ChangeNotifier {
  List<CategoryGood> categoryGoodslist = [];

  //点击大类时更换商品列表
  getCategoryChildGood(List<CategoryGood> list) {
    categoryGoodslist=list;
    notifyListeners();
  }

  //获取更多的商品列表
  getMoreCategoryChildGood(List<CategoryGood> list) {
    categoryGoodslist.addAll(list);
    notifyListeners();
  }
}
