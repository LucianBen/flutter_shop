import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/***
 *  个人中心 背景墙
 * */
class MemberCenter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _memberTop(),
    );
  }

  Widget _memberTop() {
    return Container(
      padding: EdgeInsets.all(20),
      width: ScreenUtil().setWidth(750),
      color: Colors.pinkAccent,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30),
            child: ClipOval(
              child: Image.asset("images/header.jpg", width: 100, height: 100),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              "LucianBen",
              style: TextStyle(
                  color: Colors.white, fontSize: ScreenUtil().setSp(36)),
            ),
          )
        ],
      ),
    );
  }

}
