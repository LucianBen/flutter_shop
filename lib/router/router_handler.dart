import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/page_details.dart';

Handler detailsHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String goodId = params['id'].first;
  print("传递的商品id是 $goodId");
  return DetailsPage(goodId);
});
