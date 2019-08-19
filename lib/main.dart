import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/router/base_router.dart';

import 'pages/index_page.dart';

void main() {
  return runApp(MyApp());
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
