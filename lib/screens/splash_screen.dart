import 'dart:async';

import 'package:abans_online/screens/auth_screen.dart';
import 'package:abans_online/utils/custom_colors.dart';
import 'package:abans_online/utils/navigator_manage.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 2),
      () => NavigatorManage.goPushReplace(context, AuthScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.primaryColor,
      body: Center(child: Image.asset('assets/images/logo.png')),
    );
  }
}
