import 'package:flutter/material.dart';

import 'page_category/category_left.dart';
import 'page_category/category_right.dart';
import 'page_category/category_right_top.dart';

/**
 *   分类
 * */
class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("商品分类"),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNavigator(),
            Column(
              children: <Widget>[
                RightCategoryNavigator(),
                CategoryGoods(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
