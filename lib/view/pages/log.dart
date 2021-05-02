import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_comic/view/widget/login/bar.dart';
import 'package:flutter_comic/view/widget/login/effect.dart';
import 'package:flutter_comic/view/widget/login/input.dart';

class PageLogin extends StatefulWidget {
  @override
  _PageLoginState createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  bool _protect = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("返回", "注册", null),
      body: Container(
        child: ListView(
          children: [
            LoginEffect(_protect),
            LoginInput("用户名", "请输入用户名"),
            LoginInput(
              "密码",
              "请输入密码",
              obscureText: true,
              focusChanged: (value) {
                setState(() {
                  _protect = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
