// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:abans_online/screens/auth_screen.dart';
import 'package:abans_online/screens/home_screen.dart';
import 'package:abans_online/utils/custom_colors.dart';
import 'package:abans_online/utils/navigator_manage.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      Duration(seconds: 3),
      () => FirebaseAuth.instance.authStateChanges().listen((user) {
        if (user == null) {
          NavigatorManage.goPushReplace(context, AuthScreen());
        } else {
          NavigatorManage.goPushReplace(context, HomeScreen());
        }
      }),
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
