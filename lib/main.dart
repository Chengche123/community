import 'package:flutter/material.dart';

import 'package:flutter_comic/conf/interface.dart';
import 'package:flutter_comic/view/pages/log.dart';
import 'package:flutter_comic/server/auth/api/.UserLogin.dart' as AuthService;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'comic',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("AppBar"),
        ),
        body: Column(
          children: [
            FutureBuilder<AuthService.LoginResponse>(
                future: AuthService.userLogin(
                    authServiceUrl,
                    AuthService.UserLoginRequest(
                      userName: "chengche123",
                      password: "qwe123",
                    )),
                builder: (BuildContext context,
                    AsyncSnapshot<AuthService.LoginResponse> res) {
                  switch (res.connectionState) {
                    case ConnectionState.none:
                      return new Text('Input a URL to start');
                    case ConnectionState.waiting:
                      return new Center(child: new CircularProgressIndicator());
                    case ConnectionState.active:
                      return new Text('');
                    case ConnectionState.done:
                      if (res.hasError) {
                        return new Text(
                          'errMsg: ${res.error}',
                          style: TextStyle(color: Colors.red),
                        );
                      } else {
                        return new Column(children: <Widget>[
                          Text("${res.data.accessToken} ${res.data.expiresIn}"),
                        ]);
                      }
                  }

                  return null;
                }),
          ],
        ),
      ),
    );
  }
}
