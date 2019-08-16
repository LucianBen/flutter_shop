import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/**
 *  火爆专区
 *
 */
class HotGoods extends StatefulWidget {
  List<Map> hotGoodsList = [];

  HotGoods(this.hotGoodsList);

  @override
  _HotGoodsState createState() => _HotGoodsState();
}

class _HotGoodsState extends State<HotGoods> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        _hotTitle,
        _wrapList(),
      ],
    ));
  }

  Widget _hotTitle = Container(
    margin: EdgeInsets.only(top: 10),
    padding: EdgeInsets.all(5),
    color: Colors.transparent,
    alignment: Alignment.center,
    child: Text(
      "火爆专区",
      style: TextStyle(fontSize: ScreenUtil().setSp(30), color: Colors.red),
    ),
  );

  Widget _wrapList() {
    if (widget.hotGoodsList.length != 0) {
      List<Widget> listWidget = widget.hotGoodsList.map((val) {
        return InkWell(
          onTap: () {
            print("点击火爆商品");
          },
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(bottom: 3),
            child: _item(val: val),
          ),
        );
      }).toList();
      return Wrap(
        spacing: 2, //一行2列
        children: listWidget,
      );
    } else {
      return Text("");
    }
  }

  Widget _item({val, index}) {
    return Column(
      children: <Widget>[
        Image.network(
          val['image'],
          width: ScreenUtil().setWidth(370),
        ),
        Text(
          val['name'],
          style: TextStyle(
            color: Colors.pink,
            fontSize: ScreenUtil().setSp(26),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Row(
          children: <Widget>[
            Text('￥ ${val['mallPrice']}'),
            Text(
              "￥ ${val['price']}",
              style: TextStyle(
                color: Colors.black26,
                decoration: TextDecoration.lineThrough,
              ),
            )
          ],
        )
      ],
    );
  }
}
