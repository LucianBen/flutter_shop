import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/details_good.dart';
import 'package:provide/provide.dart';

import 'page_details/details_explain.dart';
import 'page_details/details_tabbar.dart';
import 'page_details/details_top.dart';

/***
    页面详情
 **/

class DetailsPage extends StatelessWidget {
  final String goodsId;

  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text("商品详情页"),
      ),
      body: FutureBuilder(
        future: _getGoodDetail(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: ListView(
                children: <Widget>[
                  DetailsTop(),
                  DetailsExplain(),
                  DetailsTabbar(),
                ],
              ),
            );
          } else {
            return Text("暂无数据");
          }
        },
      ),
    );
  }

  Future _getGoodDetail(BuildContext context) async {
    await Provide.value<DetailsGoodProvider>(context).getGoodInfo(goodsId);
    return "完成加载";
  }
}
