import 'package:flutter/material.dart';

class NavigatorManage {
  static void goTo(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  static void goPushReplace(BuildContext context, Widget widget) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }
}
