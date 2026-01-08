import 'package:abans_online/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class AuthStateProvider extends ChangeNotifier {
  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  final TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  final TextEditingController _confirmPasswordController =
      TextEditingController();
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  Future<void> signUp() async {
    if (_emailController.text.trim().length < 3) {
      Logger().e('Invalid Email');
    } else if (_passwordController.text.trim().length < 6) {
      Logger().e('Password too weak');
    } else if (_confirmPasswordController.text.trim() !=
        _passwordController.text.trim()) {
      Logger().e('Password not match');
    } else {
      await AuthController().createUserAccount(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    }
  }
}
