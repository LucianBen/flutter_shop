import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/category_goods.dart';
import 'package:flutter_shop/provide/category_child.dart';
import 'package:flutter_shop/provide/category_child_good.dart';
import 'package:flutter_shop/router/base_router.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provide/provide.dart';

///右下侧商品展示列表
class CategoryGoods extends StatefulWidget {
  @override
  _CategoryGoodsState createState() => _CategoryGoodsState();
}

class _CategoryGoodsState extends State<CategoryGoods> {
  var scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryChildGoodProvider>(
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
                  noMoreText:
                      Provide.value<CategoryChildProvider>(context).noMoreText,
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
    Provide.value<CategoryChildProvider>(context).addPage();
    var formData = {
      'categoryId': Provide.value<CategoryChildProvider>(context).categoryId,
      'categorySubId':
          Provide.value<CategoryChildProvider>(context).categorySubId,
      'page': Provide.value<CategoryChildProvider>(context).page,
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
        Provide.value<CategoryChildProvider>(context).changeNoMoreText("没有更多了");
      } else {
        Provide.value<CategoryChildGoodProvider>(context)
            .getMoreCategoryChildGood(goodsList.data);
      }
    });
  }

  Widget _goodList(List goodList, index) {
    return InkWell(
      onTap: () {
        print("点击了商品 ${goodList[index].goodsId}");
        BaseRouter.router
            .navigateTo(context, "/detail?id=${goodList[index].goodsId}");
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
