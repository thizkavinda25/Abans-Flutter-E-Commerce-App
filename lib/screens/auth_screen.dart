import 'package:abans_online/providers/auth_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final mq = MediaQuery.of(context);
    const baseWidth = 375.0;
    final scale = ((mq.size.width / baseWidth).clamp(0.8, 1.2));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<AuthStateProvider>(
        builder: (context, authProvider, child) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0 * scale),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SafeArea(
                      child: Image.asset(
                        'assets/images/text_logo.png',
                        height: 60 * scale,
                      ),
                    ),
                    SizedBox(height: 20 * scale),
                    Text(
                      authType == 'signup'
                          ? 'Create Account'
                          : authType == 'signin'
                          ? 'Login to your Account'
                          : 'Forgot Password',
                      style: TextStyle(
                        fontSize: 25 * scale,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      authType != 'forgot'
                          ? 'Connect with Your Account'
                          : 'Enter your email to reset password',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14 * scale,
                      ),
                    ),
                    SizedBox(height: 40 * scale),
                    if (authType == 'signup')
                      CustomTextField(
                        labelText: 'Name',
                        controller: authProvider.nameController,
                      ),
                    CustomTextField(
                      labelText: 'Email Address',
                      controller: authProvider.emailController,
                    ),
                    if (authType != 'forgot')
                      CustomTextField(
                        labelText: 'Password',
                        isPassword: true,
                        controller: authProvider.passwordController,
                      ),
                    if (authType == 'signup')
                      CustomTextField(
                        labelText: 'Confirm Password',
                        isPassword: true,
                        controller: authProvider.confirmPasswordController,
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
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13 * scale,
                            ),
                          ),
                        ),
                      ),
                    SizedBox(height: 16 * scale),
                    CustomButton(
                      text: authType == 'signup'
                          ? 'Create Account'
                          : authType == 'signin'
                          ? 'Login'
                          : 'Send Reset Link',
                      onTap: () {
                        setState(() {
                          if (authType == 'signup') {
                            authProvider.signUp(context);
                          } else if (authType == 'signin') {
                            authProvider.signIn(context);
                          } else {
                            //forgot
                          }
                        });
                      },
                    ),
                    if (authType != 'forgot')
                      Center(
                        child: Text(
                          authType != 'signin'
                              ? 'Already have an account?'
                              : "Don't have an account?",
                          style: TextStyle(
                            fontSize: 13 * scale,
                            color: Colors.grey.shade600,
                          ),
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
        },
      ),
    );
  }
}
