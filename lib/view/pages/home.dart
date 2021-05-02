import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

const double appbarScrollOffset = 200;

class _HomePageState extends State<HomePage> {
  double _alphaAppbar = 0;

  final List<String> _imgUrls = [
    "https://images.dmzj1.com/webpic/18/dljkyfrls20210223.jpg",
    "https://images.dmzj1.com/webpic/9/zscsnmldbtqjfengmianl.jpg",
    "https://images.dmzj1.com/webpic/19/nuanchunzhongnizhongjiangsuxing.jpg",
  ];
  final double _imgBorderRadius = 2.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MediaQuery.removePadding(
              context: context,
              child: NotificationListener(
                onNotification: (notification) {
                  if (notification is ScrollUpdateNotification &&
                      notification.depth == 0) {
                    _onScroll(notification.metrics.pixels);
                  }
                  return true;
                },
                child: ListView(
                  children: [
                    Container(
                      height: 220,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(_imgBorderRadius),
                        child: Swiper(
                          duration: 2000,
                          itemCount: _imgUrls.length,
                          autoplay: true,
                          pagination: SwiperPagination(),
                          itemBuilder: (context, index) {
                            return RotatedBox(
                              quarterTurns: 1,
                              child: Image.network(
                                _imgUrls[index],
                                fit: BoxFit.fill,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: 800,
                      child: ListTile(
                        title: Text(""),
                      ),
                    ),
                  ],
                ),
              )),
          Opacity(
            opacity: _alphaAppbar,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 40),
              child: Text("首页"),
            ),
          ),
        ],
      ),
    );
  }

  void _onScroll(double pixels) {
    double alpha = pixels / appbarScrollOffset;
    if (alpha > 1)
      alpha = 1;
    else if (alpha < 0) alpha = 0;
    setState(() {
      _alphaAppbar = alpha;
    });
  }
}
