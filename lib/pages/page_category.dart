import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/Category.dart';
import 'package:flutter_shop/model/category_goods.dart';
import 'package:flutter_shop/provide/category_child.dart';
import 'package:flutter_shop/provide/category_child_good.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provide/provide.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("商品分类"),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNavigator(),
            Column(
              children: <Widget>[
                RightCategoryNavigator(),
                CategoryGoods(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

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
      Provide.value<CategoryChild>(context)
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
      Provide.value<CategoryChildGood>(context)
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
        Provide.value<CategoryChild>(context)
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

///右侧商品导航
class RightCategoryNavigator extends StatefulWidget {
  @override
  _RightCategoryNavigatorState createState() => _RightCategoryNavigatorState();
}

class _RightCategoryNavigatorState extends State<RightCategoryNavigator> {
  @override
  Widget build(BuildContext context) {
    return Provide<CategoryChild>(
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
              return _RightTopNavigator(
                  index, childCategory.categoryChildList[index]);
            },
          ),
        );
      },
    );
  }

  Widget _RightTopNavigator(int index, BxMallSubDto itemName) {
    bool isCheck = (index == Provide.value<CategoryChild>(context).childIndex);

    return InkWell(
      onTap: () {
        Provide.value<CategoryChild>(context)
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
      'categoryId': Provide.value<CategoryChild>(context).categoryId,
      'categorySubId': categorySubId,
      'page': 1,
    };
    await request('getMallGoods', formData: formData).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsModel goodsList = CategoryGoodsModel.fromJson(data);
      if (goodsList.data == null) {
        Provide.value<CategoryChildGood>(context).getCategoryChildGood([]);
      } else {
        Provide.value<CategoryChildGood>(context)
            .getCategoryChildGood(goodsList.data);
      }
    });
  }
}

//右下侧商品展示列表
class CategoryGoods extends StatefulWidget {
  @override
  _CategoryGoodsState createState() => _CategoryGoodsState();
}

class _CategoryGoodsState extends State<CategoryGoods> {
  var scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryChildGood>(
      builder: (context, child, data) {
        try {
          //列表位置，放到最上面
          scrollController.jumpTo(0);
        } catch (e) {
          print("进入页面第一次初始化 $e");
        }
        if (data.categoryGoodslist.length > 0) {
          return Expanded(
            child: Container(
              width: ScreenUtil().setWidth(570),
              child: EasyRefresh(
                footer: ClassicalFooter(
                  bgColor: Colors.white,
                  textColor: Colors.pink,
                  infoColor: Colors.pink,
                  loadedText: '上拉加载',
                  noMoreText: Provide.value<CategoryChild>(context).noMoreText,
                  infoText: '加载中...',
                ),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: data.categoryGoodslist.length,
                  itemBuilder: (context, index) {
                    return _goodList(data.categoryGoodslist, index);
                  },
                ),
                onLoad: () async {
                  print("===== 上拉加载更多分类商品 =====");
                  _getMoreGoodsList();
                },
              ),
            ),
          );
        } else {
          return Container(
            margin: EdgeInsets.only(top: 100),
            child: Text("暂无数据"),
          );
        }
      },
    );
  }

  //获取更多各个小类的商品列表
  void _getMoreGoodsList() async {
    Provide.value<CategoryChild>(context).addPage();
    var formData = {
      'categoryId': Provide.value<CategoryChild>(context).categoryId,
      'categorySubId': Provide.value<CategoryChild>(context).categorySubId,
      'page': Provide.value<CategoryChild>(context).page,
    };
    await request('getMallGoods', formData: formData).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsModel goodsList = CategoryGoodsModel.fromJson(data);
      if (goodsList.data == null) {
        Fluttertoast.showToast(
          msg: "没有更多了",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.pink,
          textColor: Colors.white,
          fontSize: 16,
        );
        Provide.value<CategoryChild>(context).changeNoMoreText("没有更多了");
      } else {
        Provide.value<CategoryChildGood>(context)
            .getMoreCategoryChildGood(goodsList.data);
      }
    });
  }

  Widget _goodList(List goodList, index) {
    return InkWell(
      onTap: () {
        print("点击了商品");
      },
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(width: 1, color: Colors.black12),
            )),
        child: Row(
          children: <Widget>[
            Container(
              //商品图片
              width: ScreenUtil().setWidth(180),
              child: Image.network(goodList[index].image),
            ),
            Column(
              children: <Widget>[
                Container(
                  //商品名称
                  padding: EdgeInsets.only(top: 10),
                  width: ScreenUtil().setWidth(370),
                  child: Text(
                    goodList[index].goodsName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: ScreenUtil().setSp(26)),
                  ),
                ),
                Container(
                    //商品价格
                    margin: EdgeInsets.only(top: 10),
                    width: ScreenUtil().setWidth(370),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "价格：￥ ${goodList[index].presentPrice}     ",
                          style: TextStyle(
                              color: Colors.pink,
                              fontSize: ScreenUtil().setSp(22)),
                        ),
                        Text("价格：￥ ${goodList[index].oriPrice}",
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: ScreenUtil().setSp(20))),
                      ],
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
