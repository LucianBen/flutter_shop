import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/router/base_router.dart';

//商品推荐
class Recommend extends StatelessWidget {
  final List recommendList;

  Recommend({this.recommendList});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: ScreenUtil().setHeight(420),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommendList(),
        ],
      ),
    );
  }

  //标题布局
  Widget _titleWidget() {
    return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.black12, width: 0.5)),
        ),
        child: Text(
          "商品推荐",
          style: TextStyle(color: Colors.pink),
        ));
  }

  //单个商品布局
  Widget _item(context, index) {
    return InkWell(
      onTap: () {
        BaseRouter.router.navigateTo(
            context, "/detail?id=${recommendList[index]['goodsId']}");
      },
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(left: BorderSide(color: Colors.black12, width: 0.5)),
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('￥ ${recommendList[index]['mallPrice']}'),
            Text(
              '￥ ${recommendList[index]['price']}',
              style: TextStyle(
                  decoration: TextDecoration.lineThrough, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  //横向列表方法
  Widget _recommendList() {
    return Container(
      height: ScreenUtil().setHeight(350),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context, index) {
          return (_item(context, index));
        },
      ),
    );
  }
}
