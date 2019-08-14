import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/config/httpHeaders.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String showText = "还没有请求数据";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("首页"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  _jike();
                },
                child: Text("请求数据"),
              ),
              Text(showText),
            ],
          ),
        ),
      ),
    );
  }

  void _jike() {
    print("请求数据中----------------------------");
    getHttp().then((val) {
      setState(() {
        showText = val['data'].toString();
      });
    });
  }

  Future getHttp() async {
    try {
      Dio dio = new Dio();
      dio.options.headers = httpHeaders;
      Response response =
          await dio.get("https://time.geekbang.org/serv/v1/column/newAll");
      print(response);
      return response.data;
    } catch (e) {
      return print(e);
    }
  }
}
