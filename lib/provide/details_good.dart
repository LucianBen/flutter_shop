import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/model/details.dart';
import 'package:flutter_shop/service/service_method.dart';

class DetailsGoodProvider with ChangeNotifier {
  DetailsModel goodInfo = null;
  bool isLeft = true;
  bool isRight = false;

  //从后台获取数据
  getGoodInfo(String id) {
    var formData = {'goodId': id};
    request('getGoodDetailById', formData: formData).then((val) {
      var data = json.decode(val.toString());
      goodInfo = DetailsModel.fromJson(data);
      notifyListeners();
    });
  }

  //tabBar（详情、评论）的切换
  switchLeftOrRight(String switchState) {
    if (switchState == 'left') {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }
}
