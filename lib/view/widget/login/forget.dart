import 'package:flutter/material.dart';

class ForgetButton extends StatelessWidget {
  final VoidCallback _onPress;

  const ForgetButton(this._onPress, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 20, top: 8),
      child: InkWell(
        onTap: _onPress,
        child: Text(
          "忘记密码",
          style: TextStyle(color: Colors.blue),
        ),
      ),
    );
  }
}
