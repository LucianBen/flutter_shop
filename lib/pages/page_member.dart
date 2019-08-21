import 'package:flutter/material.dart';

import 'page_member/member_order.dart';
import 'page_member/member_top.dart';

/**
 *   个人中心
 * */
class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("会员中心"),
      ),
      body: ListView(
        children: <Widget>[
          MemberCenter(),
          MemberOrder(),
        ],
      ),
    );
  }
}
