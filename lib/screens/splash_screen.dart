// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:abans_online/screens/auth_screen.dart';
import 'package:abans_online/utils/custom_colors.dart';
import 'package:abans_online/utils/navigator_manage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser == null) {
      Timer(const Duration(seconds: 2), () {
        NavigatorManage.goPushReplace(context, const AuthScreen());
      });
    } else {
      Timer(const Duration(seconds: 0), () {
        Provider.of<UserProvider>(
          context,
          listen: false,
        ).fetchUserData(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.primaryColor,
      body: Center(child: Image.asset('assets/images/logo.png')),
    );
  }
}
