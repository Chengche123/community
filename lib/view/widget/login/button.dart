import 'package:flutter/material.dart';
import 'package:flutter_comic/conf/view/color.dart';

class LoginButton extends StatelessWidget {
  final String title;
  final bool enable;
  final VoidCallback onPressed;

  const LoginButton(this.title, {Key key, this.enable = true, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          height: 45,
          onPressed: enable ? onPressed : null,
          disabledColor: primary[50],
          color: primary,
          child:
              Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
      ),
    );
  }
}
