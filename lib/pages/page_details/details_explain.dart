import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsExplain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: _explain("》》》"),
    );
  }

  Widget _explain(content) {
    return Container(
      padding: EdgeInsets.all(10),
      width: ScreenUtil().setWidth(750),
      child: Text(
        "说明： > 急速送达 > 正品保证",
        style: TextStyle(color: Colors.pinkAccent, fontSize: ScreenUtil().setSp(30)),
      ),
    );
  }
}
