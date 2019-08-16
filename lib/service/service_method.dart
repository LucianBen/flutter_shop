import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_shop/config/service_url.dart';

Future request(url, {formData}) async {
  try {
    print('开始获取数据');
    print(servicePath[url]);

    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    if (formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }
    if (response.statusCode == 200) {
//      print(response.data);
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    print('ERROR 如下');
    return print(e);
  }
}
