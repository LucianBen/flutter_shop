import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/category_child.dart';
import 'package:flutter_shop/provide/category_child_good.dart';
import 'package:flutter_shop/provide/details_good.dart';
import 'package:flutter_shop/router/base_router.dart';
import 'package:provide/provide.dart';

import 'pages/index_page.dart';
import 'provide/cart.dart';

void main() {
  var providers = Providers()
    ..provide(Provider<CategoryChildProvider>.value(CategoryChildProvider()))
    ..provide(
        Provider<CategoryChildGoodProvider>.value(CategoryChildGoodProvider()))
    ..provide(Provider<DetailsGoodProvider>.value(DetailsGoodProvider()))
    ..provide(Provider<CartProvider>.value(CartProvider()));

  return runApp(ProviderNode(
    child: MyApp(),
    providers: providers,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = Router();
    BaseRouter.configureRouter(router);
    BaseRouter.router = router;

    return Container(
      child: MaterialApp(
        title: "百姓生活+",
        onGenerateRoute: BaseRouter.router.generator,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.pink),
        home: IndexPage(),
      ),
    );
  }
}
