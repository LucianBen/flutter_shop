import 'package:flutter/material.dart';

import 'page_member/appbar_gradient.dart';
import 'page_member/member_other.dart';
import 'page_member/member_top.dart';

/**
 *   个人中心
 * */
class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        gradientStart: Color(0xFFE91E63),
        gradientEnd: Color(0xFFFF4081),
        title: Text("会员中心"),
        elevation: 0.0,
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
