import 'package:flutter/material.dart';
import 'package:flutter_shop/model/Category.dart';

class CategoryChild with ChangeNotifier {
  List<BxMallSubDto> categoryChildList = [];
  int childIndex = 0; //子类高亮索引
  String categoryId = '4'; //大类的Id
  String categorySubId = ''; //小类的Id
  int page = 1; //列表页数
  String noMoreText = '已全部加装完毕'; //显示没有数据

  //大类切换逻辑
  getCategoryChild(List<BxMallSubDto> list, String id) {
    page = 1;
    noMoreText = '';
    childIndex = 0;
    categoryId = id;

    BxMallSubDto all = BxMallSubDto();
    all.mallCategoryId = '00';
    all.mallSubId = '';
    all.comments = 'null';
    all.mallSubName = '全部';
    categoryChildList = [all];

    categoryChildList.addAll(list);
    notifyListeners();
  }

  //改变子类索引
  changeChildIndex(index, String id) {
    page = 1;
    noMoreText = '';
    childIndex = index;
    categorySubId = id;
    notifyListeners();
  }

  //增加Page的方法
  addPage() {
    page++;
  }

//改变noMoreText数据
  changeNoMoreText(String text) {
    noMoreText = text;
    notifyListeners();
  }
}
