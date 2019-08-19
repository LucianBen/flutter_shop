import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/router/router_handler.dart';

class BaseRouter {
  static Router router;

  static String root = "/";
  static String detailPage = "/detail";

  static void configureRouter(Router router) {
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print("没有找到路由");
        return ;
      },
    );

    router.define(detailPage, handler: detailsHandler);
  }
}
