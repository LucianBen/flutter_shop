import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/current_index.dart';
import 'package:provide/provide.dart';

import 'page_cart.dart';
import 'page_category.dart';
import 'page_home.dart';
import 'page_member.dart';

class IndexPage extends StatelessWidget {
  List<BottomNavigationBarItem> itemBars = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text("首页"),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title: Text("分类"),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart),
      title: Text("购物车"),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title: Text("会员中心"),
    )
  ];

  final List<Widget> tabList = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Provide<CurrentIndexProvider>(builder: (context, child, val) {
      int currentIndex =
          Provide.value<CurrentIndexProvider>(context).currentIndex;
      return Scaffold(
        backgroundColor: Color.fromARGB(244, 245, 245, 1),
        bottomNavigationBar: BottomNavigationBar(
          items: itemBars,
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            Provide.value<CurrentIndexProvider>(context).changeIndex(index);
          },
        ),
        body: IndexedStack(
          index: currentIndex,
          children: tabList,
        ),
      );
    });
  }
}

/*
class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  List<BottomNavigationBarItem> itemBars = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text("首页"),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title: Text("分类"),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart),
      title: Text("购物车"),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title: Text("会员中心"),
    )
  ];

  final List<Widget> tabList = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];
  int currentIndex = 0;
  var currentPage;

  @override
  void initState() {
    currentPage = tabList[currentIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(244, 245, 245, 1),
      bottomNavigationBar: BottomNavigationBar(
        items: itemBars,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            currentPage = tabList[index];
          });
        },
      ),
      body: IndexedStack(
        index: currentIndex,
        children: tabList,
      ),
    );
  }
}
*/
