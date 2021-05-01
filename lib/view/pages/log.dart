import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_comic/server/auth/api/api.pb.dart';
import 'package:flutter_comic/view/pages/home.dart';
import 'package:flutter_comic/server/auth/api/api.pb.http.dart';
import 'package:flutter_comic/conf/interface.dart';

String token = "";

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _sizedBoxSpace = SizedBox(height: 50);
  String _userName = "", _password = "";
  final _formKey = GlobalKey<FormState>();

  _showCupertinoDialog(String text) {
    showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: CupertinoAlertDialog(
            content: Text(text),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Container(
              height: 40,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                decoration: InputDecoration(filled: true, hintText: "用户名"),
                onSaved: (newValue) {
                  _userName = newValue;
                },
              ),
            ),
            _sizedBoxSpace,
            Container(
              height: 40,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: PasswordField(
                hintText: "密码",
                onSaved: (newValue) {
                  _password = newValue;
                },
              ),
            ),
            SizedBox(
              height: 50,
            ),
            CupertinoButton(
              alignment: Alignment.center,
              color: Colors.blue,
              child: Text("登录"),
              onPressed: () {
                _formKey.currentState.save();

                if (_userName == "" || _password == "") {
                  _showCupertinoDialog("用户名或密码为空");
                  // 卫戍
                  return;
                }

                AuthServiceClient(authServiceBaseUrl)
                    .userLogin(
                        UserLoginRequest(
                          userName: _userName,
                          password: _password,
                        ),
                        null)
                    .then((res) {
                  token = res.accessToken;
                  _showCupertinoDialog("登录成功");
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return HomePage();
                    },
                  ));
                }).catchError((e) {
                  _showCupertinoDialog("登录失败: $e");
                });

                // 发起登录http请求
                // userLogin(
                //     authServiceUrl,
                //     UserLoginRequest(
                //       userName: _userName,
                //       password: _password,
                //     )).then((res) {
                //   token = res.accessToken;
                //   _showCupertinoDialog("登录成功");
                //   Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) {
                //       return HomePage();
                //     },
                //   ));
                // }).catchError((e) {
                //   _showCupertinoDialog("登录失败: $e");
                // });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
  });

  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.fieldKey,
      obscureText: _obscureText,
      //maxLength: 8,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        filled: true,
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
        suffixIcon: GestureDetector(
          dragStartBehavior: DragStartBehavior.down,
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
    );
  }
}
