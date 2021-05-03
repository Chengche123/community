import 'package:flutter/material.dart';
import 'package:flutter_comic/conf/server/url.dart';
import 'package:flutter_comic/server/auth/api/api.pb.dart';
import 'package:flutter_comic/server/auth/api/api.pb.http.dart';
import 'package:flutter_comic/share/util/string.dart';
import 'package:flutter_comic/share/util/toast.dart';
import 'package:flutter_comic/view/navigator/hi_navigator.dart';
import 'package:flutter_comic/view/widget/login/bar.dart';
import 'package:flutter_comic/view/widget/login/button.dart';
import 'package:flutter_comic/view/widget/login/effect.dart';
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
      print('login:current: ${current.routeStatus}');
      print('login:pre: ${pre.routeStatus}');
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
            LoginButton("登录", enable: _buttonEnable, onPressed: _send),
          ],
        ),
      ),
    );
  }

  _send() async {
    try {
      await AuthServiceClient(authServiceBaseUrl).userLogin(
          UserLoginRequest(
            userName: _userName,
            password: _password,
          ),
          null);
      showToast("登录成功");
      HiNavigator.getInstance().jumpTo(RouteStatus.home);
    } catch (e) {
      showWarnToast(e.toString());
      HiNavigator.getInstance().jumpTo(RouteStatus.home);
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
