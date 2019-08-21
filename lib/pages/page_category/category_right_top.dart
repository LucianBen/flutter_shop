import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/category.dart';
import 'package:flutter_shop/model/category_goods.dart';
import 'package:flutter_shop/provide/category_child.dart';
import 'package:flutter_shop/provide/category_child_good.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:provide/provide.dart';

///右侧商品导航
class RightCategoryNavigator extends StatefulWidget {
  @override
  _RightCategoryNavigatorState createState() => _RightCategoryNavigatorState();
}

class _RightCategoryNavigatorState extends State<RightCategoryNavigator> {
  @override
  Widget build(BuildContext context) {
    return Provide<CategoryChildProvider>(
      builder: (context, child, childCategory) {
        return Container(
          height: ScreenUtil().setHeight(80),
          width: ScreenUtil().setWidth(570),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: childCategory.categoryChildList.length,
            itemBuilder: (context, index) {
              return _rightTopNavigator(
                  index, childCategory.categoryChildList[index]);
            },
          ),
        );
      },
    );
  }

  Widget _rightTopNavigator(int index, BxMallSubDto itemName) {
    bool isCheck = (index == Provide.value<CategoryChildProvider>(context).childIndex);

    return InkWell(
      onTap: () {
        Provide.value<CategoryChildProvider>(context)
            .changeChildIndex(index, itemName.mallSubId);
        _getGoodsList(itemName.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Text(
          itemName.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(26),
            color: isCheck ? Colors.pink : Colors.black,
          ),
        ),
      ),
    );
  }

  //得到各个小类的商品列表
  void _getGoodsList(String categorySubId) async {
    var formData = {
      'categoryId': Provide.value<CategoryChildProvider>(context).categoryId,
      'categorySubId': categorySubId,
      'page': 1,
    };
    await request('getMallGoods', formData: formData).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsModel goodsList = CategoryGoodsModel.fromJson(data);
      if (goodsList.data == null) {
        Provide.value<CategoryChildGoodProvider>(context).getCategoryChildGood([]);
      } else {
        Provide.value<CategoryChildGoodProvider>(context)
            .getCategoryChildGood(goodsList.data);
      }
    });
  }
}
