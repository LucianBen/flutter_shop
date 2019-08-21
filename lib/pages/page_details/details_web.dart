import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/details_good.dart';
import 'package:provide/provide.dart';

class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodDetail = Provide.value<DetailsGoodProvider>(context)
        .goodInfo
        .data
        .goodInfo
        .goodsDetail;
    return Provide<DetailsGoodProvider>(
      builder: (context, child, val) {
        var isLeft = Provide.value<DetailsGoodProvider>(context).isLeft;
        if (isLeft) {
          return Container(
            child: Html(
              data: goodDetail
            ),
          );
        } else {
          return Container(
            width: ScreenUtil().setWidth(750),
            alignment: Alignment.center,
            child: Text("暂无数据"),
          );
        }
      },
    );
  }
}
