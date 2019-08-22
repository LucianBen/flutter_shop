import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartCount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(175),
      margin: EdgeInsets.only(top: 5),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Row(
        children: <Widget>[_reduceButton(),_countArea(23),_addButton()],
      ),
    );
  }

  //减少按钮
  Widget _reduceButton() {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setWidth(50),
        width: ScreenUtil().setHeight(50),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(right: BorderSide(width: 1, color: Colors.black12)),
        ),
        child: Text("-"),
      ),
    );
  }

  //增加按钮
  Widget _addButton() {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setWidth(50),
        width: ScreenUtil().setHeight(50),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(left: BorderSide(width: 1, color: Colors.black12)),
        ),
        child: Text("+"),
      ),
    );
  }

  //中间数量显示区域
  Widget _countArea(count) {
    return Container(
      height: ScreenUtil().setHeight(50),
      width: ScreenUtil().setWidth(75),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text("$count"),
    );
  }
}
