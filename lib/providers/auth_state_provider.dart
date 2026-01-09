import 'package:abans_online/controllers/auth_controller.dart';
import 'package:abans_online/utils/custom_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AuthStateProvider extends ChangeNotifier {
  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  final TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  final TextEditingController _confirmPasswordController =
      TextEditingController();
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  Future<void> signUp(BuildContext context) async {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      CustomDialogs.showErrorSnackBar(context, 'Please fill all the fields');
    } else if (RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(_emailController.text) ==
        false) {
      CustomDialogs.showErrorSnackBar(
        context,
        'Please enter a valid email address',
      );
    } else if (_passwordController.text.trim().length < 6) {
      CustomDialogs.showErrorSnackBar(context, 'Password too weak');
    } else if (_confirmPasswordController.text.trim() !=
        _passwordController.text.trim()) {
      CustomDialogs.showErrorSnackBar(context, "Password doesn't match");
    } else {
      EasyLoading.show(status: 'Creating Account...');
      await AuthController().createUserAccount(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      EasyLoading.dismiss();
      _emailController.text = '';
      _passwordController.text = '';
      _confirmPasswordController.text = '';
    }
  }
}
