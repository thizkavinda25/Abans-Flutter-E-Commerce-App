import 'package:abans_online/screens/home_screen.dart';
import 'package:abans_online/utils/navigator_manage.dart';
import 'package:flutter/material.dart';

import '../components/custom_button.dart';
import '../components/custom_text_field.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String authType = 'signup';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/text_logo.png', height: 70),
              SizedBox(height: 30),
              Text(
                authType == 'signup'
                    ? 'Create Account'
                    : authType == 'signin'
                    ? 'Login to your Account'
                    : 'Forgot Password',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
              Text(
                authType != 'forgot'
                    ? 'Connect with Your Account'
                    : 'Enter your email to reset password',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              SizedBox(height: 40),
              CustomTextField(labelText: 'Email Address'),
              if (authType != 'forgot')
                CustomTextField(labelText: 'Password', isPassword: true),
              if (authType == 'signup')
                CustomTextField(
                  labelText: 'Confirm Password',
                  isPassword: true,
                ),
              if (authType == 'signin')
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        authType = 'forgot';
                      });
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                ),
              SizedBox(height: 16),
              CustomButton(
                text: authType == 'signup'
                    ? 'Create Account'
                    : authType == 'signin'
                    ? 'Login'
                    : 'Send Reset Link',
                onTap: () {
                  NavigatorManage.goTo(context, HomeScreen()); 
                },
              ),
              if (authType != 'forgot')
                Center(
                  child: Text(
                    authType != 'signin'
                        ? 'Already have an account?'
                        : "Don't have an account?",
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ),
              CustomButton(
                text: authType == 'signup'
                    ? 'Sign In'
                    : authType == 'signin'
                    ? 'Sign Up'
                    : 'Sign In',
                isOutlineButton: true,
                onTap: () {
                  setState(() {
                    if (authType == 'signin') {
                      authType = 'signup';
                    } else {
                      authType = 'signin';
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
