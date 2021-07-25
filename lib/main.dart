import 'package:flutter/material.dart';
import 'package:flutter_comic/conf/view/color.dart';
import 'package:flutter_comic/store/hi_cache.dart';
import 'package:flutter_comic/view/navigator/delegate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  BiliRouteDelegate _routeDelegate = BiliRouteDelegate();

  Widget _widget;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        //进行初始化
        future: HiCache.preInit(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          //定义route
          _widget = snapshot.connectionState == ConnectionState.done
              ? Router(routerDelegate: _routeDelegate)
              : Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );

          return MaterialApp(
            home: widget1,
            theme: ThemeData(primarySwatch: white),
            title: "二次元社区",
          );
        });
  }

  // 拦截将要跳转的页面
  Widget get widget1 {
    return _widget;
  }
}
