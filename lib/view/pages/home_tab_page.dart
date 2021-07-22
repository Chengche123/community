import 'package:flutter/material.dart';
import 'package:flutter_comic/server/app-view/api/app.view.v1.api.pb.dart';
import 'package:flutter_comic/view/widget/share/banner.dart';

class HomeTabPage extends StatefulWidget {
  final String name;
  final List<BannerMo> bannerList;

  HomeTabPage(this.name, {Key key, this.bannerList}) : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: ListView(
          children: [if (widget.bannerList != null) _banner()],
        ));
  }

  _banner() {
    return Padding(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: HiBanner(widget.bannerList));
  }
}
