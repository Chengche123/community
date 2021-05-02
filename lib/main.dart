import 'package:flutter/material.dart';
import 'package:flutter_comic/conf/view/color.dart';
import 'package:flutter_comic/store/ccache.dart';
import 'package:flutter_comic/view/pages/log.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CCache.preinit();
    return MaterialApp(
      title: 'comic',
      theme: ThemeData(
        primarySwatch: white,
      ),
      home: LoginPage(),
    );
  }
}
