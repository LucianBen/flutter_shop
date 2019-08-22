import 'package:amap_base/amap_base.dart';
import 'package:flutter/material.dart';

class Amap extends StatefulWidget {
  @override
  _AmapState createState() => _AmapState();
}

AMapController _controller;

class _AmapState extends State<Amap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("高德地图"),
      ),
      body: AMapView(
        onAMapViewCreated: (controller) {
          _controller = controller;
        },
        amapOptions: AMapOptions(
            compassEnabled: false,
            //是否压缩
            zoomControlsEnabled: true,
            //是否放大按钮
            logoPosition: LOGO_POSITION_BOTTOM_LEFT, //logo标志
            camera: CameraPosition(
              target: LatLng(41.851827, 112.801637),
              zoom: 4,
            )),
      ),
    );
  }
}
