import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

//广告Banner
class AdBanner extends StatelessWidget {
  final String adPicture;

  AdBanner({this.adPicture});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicture),
    );
  }
}

//店长电话
class LeaderPhone extends StatelessWidget {
  final String leaderPhone;
  final String leaderImage;

  LeaderPhone({this.leaderPhone, this.leaderImage});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _launchURL,
      child: Image.network(leaderImage),
    );
  }

  void _launchURL() async {
    String phoneUrl = "tel:" + leaderPhone;
    if (await canLaunch(phoneUrl)) {
      await launch(phoneUrl);
    } else {
      throw ("$phoneUrl 发生错误");
    }
  }
}
