import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/category.dart';
import 'package:flutter_shop/model/category_goods.dart';
import 'package:flutter_shop/provide/category_child.dart';
import 'package:flutter_shop/provide/category_child_good.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:provide/provide.dart';

///左侧大类导航
class LeftCategoryNavigator extends StatefulWidget {
  @override
  _LeftCategoryNavigatorState createState() => _LeftCategoryNavigatorState();
}

class _LeftCategoryNavigatorState extends State<LeftCategoryNavigator> {
  List list = [];
  var currentIndex = 0;

  @override
  void initState() {
    _getCategory();
    _getGoodsList();
    super.initState();
  }

  void _getCategory() async {
    await request('getCategory').then((val) {
      var data = json.decode(val.toString());
      CategoryModel categoryData = CategoryModel.fromJson(data);
      setState(() {
        list = categoryData.data;
      });
      Provide.value<CategoryChildProvider>(context)
          .getCategoryChild(list[0].bxMallSubDto, list[0].mallCategoryId);
    });
  }

  void _getGoodsList({String categoryId}) async {
    var formData = {
      'categoryId': categoryId == null ? '4' : categoryId,
      'categorySubId': "",
      'page': 1,
    };
    await request('getMallGoods', formData: formData).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsModel goodsList = CategoryGoodsModel.fromJson(data);
      Provide.value<CategoryChildGoodProvider>(context)
          .getCategoryChildGood(goodsList.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
          border: Border(right: BorderSide(color: Colors.black12, width: 1))),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _LeftNavigator(index);
        },
      ),
    );
  }

  Widget _LeftNavigator(int index) {
    bool isClick = (currentIndex == index);
    return InkWell(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
        var childList = list[index].bxMallSubDto;
        Provide.value<CategoryChildProvider>(context)
            .getCategoryChild(childList, list[index].mallCategoryId);

        //获取该大类的商品数据
        var categoryId = list[index].mallCategoryId;
        _getGoodsList(categoryId: categoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 15),
        decoration: BoxDecoration(
            color: isClick ? Color.fromRGBO(236, 236, 236, 1) : Colors.white,
            border: Border(
              bottom: BorderSide(width: 1, color: Colors.black12),
            )),
        child: Text(
          list[index].mallCategoryName.toString(),
          style: TextStyle(fontSize: ScreenUtil().setSp(30)),
        ),
      ),
    );
  }
}
