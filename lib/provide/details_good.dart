import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/model/details.dart';
import 'package:flutter_shop/service/service_method.dart';

class DetailsGoodProvider with ChangeNotifier {
  DetailsModel goodInfo = null;

  //从后台获取数据
  getGoodInfo(String id) {
    var formData = {'goodId': id};
    request('getGoodDetailById', formData: formData).then((val) {
      var data = json.decode(val.toString());
//      print("===请求商品详情数据=====\n" + val.toString());
      goodInfo = DetailsModel.fromJson(data);
      notifyListeners();
    });
  }
}
