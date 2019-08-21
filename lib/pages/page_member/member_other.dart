import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/***
 *  个人中心 我的订单 & 其他入口
 * */
class MemberOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      child: Column(
        children: <Widget>[
          _listTile(00, Icon(Icons.list), "我的订单", topMargin: 10.0),
          Row(
            children: <Widget>[
              _columnLayout(0, "待付款",
                  Icon(Icons.attach_money, color: Colors.purple, size: 30)),
              _columnLayout(1, "待发货",
                  Icon(Icons.attach_money, color: Colors.purple, size: 30)),
              _columnLayout(2, "待收货",
                  Icon(Icons.attach_money, color: Colors.purple, size: 30)),
              _columnLayout(3, "待评价",
                  Icon(Icons.attach_money, color: Colors.purple, size: 30)),
            ],
          ),
          _listTile(10, Icon(Icons.card_membership), "领取优惠券", topMargin: 10.0),
          _listTile(11, Icon(Icons.card_membership), "已领取优惠券"),
          _listTile(12, Icon(Icons.location_on), "地址管理"),
          _listSubTile(Icon(Icons.phone), "客服管理", "0393-8800315"),
          _listTile(21, Icon(Icons.phone), "关于我们"),
        ],
      ),
    );
  }

  Widget _listTile(int index, Icon iconLeading, String text,
      {double topMargin = 0.00}) {
    return InkWell(
      onTap: () {
        print("ListTile---------->$index");
      },
      child: Container(
        margin: EdgeInsets.only(top: topMargin),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Colors.black12, width: 1),
            )),
        child: ListTile(
          leading: iconLeading,
          trailing: Icon(Icons.chevron_right),
          title: Text(text),
        ),
      ),
    );
  }

  Widget _listSubTile(
    Icon iconLeading,
    String text,
    String subtitle,
  ) {
    return InkWell(
      onTap: () {
        print("打电话啦");
      },
      child: Container(
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Colors.black12, width: 1),
            )),
        child: ListTile(
          leading: iconLeading,
          trailing: Icon(Icons.chevron_right),
          title: Text(text),
          subtitle: Text(subtitle),
        ),
      ),
    );
  }


  Widget _columnLayout(int index, String text, Icon icon) {
    return InkWell(
      onTap: () {
        print("ColumnLayout============$index");
      },
      child: Container(
        width: ScreenUtil().setWidth(187.5),
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        color: Colors.white,
        child: Column(
          children: <Widget>[icon, Text(text)],
        ),
      ),
    );
  }
}
