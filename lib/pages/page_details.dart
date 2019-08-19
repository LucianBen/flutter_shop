import 'package:flutter/material.dart';

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
                child: Column(
                  children: <Widget>[Text("$goodsId")],
                ),
              );
            } else {
              return Text("暂无数据");
            }
          }),
    );
  }

  Future _getGoodDetail(BuildContext context) async {
//    await Provide.value<DetailsGoodProvider>(context).getGoodInfo(goodsId);

    return "完成加载";
  }
}
