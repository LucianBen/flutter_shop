import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 5X2 Gridview 类别导航栏
class TopNavigator extends StatelessWidget {
  final List topNavigatorList;

  TopNavigator({this.topNavigatorList});

  Widget _gridviewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print("点击了导航");
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width: ScreenUtil().setWidth(95),
          ),
          Text(item['mallCategoryName']),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (topNavigatorList.length > 10) {
      topNavigatorList.removeRange(10, topNavigatorList.length);
    }
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3),
      child: GridView.count(
        //屏蔽GridView内部滚动；
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        padding: EdgeInsets.all(5),
        children: topNavigatorList.map((item) {
          return _gridviewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}