import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/details_good.dart';
import 'package:provide/provide.dart';

class DetailsTabbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsGoodProvider>(
      builder: (context, child, val) {
        return Provide<DetailsGoodProvider>(
          builder: (context, child, val) {
            var isLeft = Provide.value<DetailsGoodProvider>(context).isLeft;
            var isRight = Provide.value<DetailsGoodProvider>(context).isRight;

            return Container(
              child: Row(
                children: <Widget>[
                  _leftTabbar(context, isLeft),
                  _rightTabbar(context, isRight),
                ],
              ),
            );
          },
        );
      },
    );
  }

  //左侧tabbar
  Widget _leftTabbar(BuildContext context, bool isLeft) {
    return InkWell(
      onTap: () {
        Provide.value<DetailsGoodProvider>(context).switchLeftOrRight("left");
      },
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    width: 1, color: isLeft ? Colors.pink : Colors.black12))),
        child: Text(
          "详情",
          style: TextStyle(color: isLeft ? Colors.pink : Colors.black12),
        ),
      ),
    );
  }

  //右侧tabbar
  Widget _rightTabbar(BuildContext context, bool isRight) {
    return InkWell(
      onTap: () {
        Provide.value<DetailsGoodProvider>(context).switchLeftOrRight("right");
      },
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    width: 1, color: isRight ? Colors.pink : Colors.black54))),
        child: Text(
          "评论",
          style: TextStyle(color: isRight ? Colors.pink : Colors.black54),
        ),
      ),
    );
  }
}
