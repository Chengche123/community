import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_comic/server/auth/api/api.pb.dart';
import 'package:flutter_comic/server/auth/api/dio.dart';
import 'package:flutter_comic/share/util/string.dart';
import 'package:flutter_comic/share/util/toast.dart';
import 'package:flutter_comic/view/navigator/hi_navigator.dart';
import 'package:flutter_comic/view/widget/login/bar.dart';
import 'package:flutter_comic/view/widget/login/button.dart';
import 'package:flutter_comic/view/widget/login/effect.dart';
import 'package:flutter_comic/view/widget/login/forget.dart';
import 'package:flutter_comic/view/widget/login/input.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _protect = false;
  bool _buttonEnable = false;
  String _userName;
  String _password;
  RouteChangeListener _listener;

  @override
  void initState() {
    super.initState();
    HiNavigator.getInstance().addListener(this._listener = (current, pre) {
      print('login:current: ${current?.rawPage}');
      print('login:pre: ${pre?.rawPage}');
    });
  }

  @override
  void dispose() {
    HiNavigator.getInstance().removeListener(this._listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("登录", "", null),
      body: Container(
        child: ListView(
          children: [
            LoginEffect(_protect),
            LoginInput(
              "用户名",
              "请输入用户名",
              onChanged: (value) {
                _userName = value;
                _checkButton();
              },
            ),
            LoginInput(
              "密码",
              "请输入密码",
              onChanged: (value) {
                _password = value;
                _checkButton();
              },
              obscureText: true,
              focusChanged: (value) {
                setState(() {
                  _protect = value;
                });
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                LoginButton("登 录 / 注 册",
                    enable: _buttonEnable, onPressed: _send),
                ForgetButton(_forget),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _forget() {
    print("forget password");
  }

  _send() async {
    try {
      await AuthServiceClientProxy.getInstance().userLogin(
          UserLoginRequest(
            userName: _userName,
            password: _password,
          ),
          null);
      showToast("登录成功");
      HiNavigator.getInstance().jumpTo(RouteStatus.home);
    } on DioError catch (e) {
      showWarnToast('接口返回失败: ${e.response?.statusCode} ${e.response?.data}');
    }
  }

  _checkButton() {
    bool enable;
    if (isNotEmpty(_userName) && isNotEmpty(_password)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      _buttonEnable = enable;
    });
  }
}
