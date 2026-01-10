import 'package:abans_online/controllers/auth_controller.dart';
import 'package:abans_online/controllers/user_controller.dart';
import 'package:abans_online/models/user_model.dart';
import 'package:abans_online/screens/home_screen.dart';
import 'package:abans_online/utils/custom_dialogs.dart';
import 'package:abans_online/utils/navigator_manage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'user_provider.dart';

class AuthStateProvider extends ChangeNotifier {
  final TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  final TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  final TextEditingController _confirmPasswordController =
      TextEditingController();
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  Future<void> signUp(BuildContext context) async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
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
      EasyLoading.show(status: 'Creating Account');
      final user = await AuthController().createUserAccount(
        context: context,
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (user != null) {
        final userModel = UserModel(
          email: _emailController.text.trim(),
          name: _nameController.text.trim(),
          uid: user.uid,
        );
        final isSuccess = await UserController().saveUserData(userModel);
        EasyLoading.dismiss();
        _nameController.clear();
        _emailController.clear();
        _passwordController.clear();
        _confirmPasswordController.clear();
        if (isSuccess && context.mounted) {
          NavigatorManage.goPushReplace(context, HomeScreen());
        }
      }
    }
  }

  Future<void> signIn(BuildContext context) async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      CustomDialogs.showErrorSnackBar(context, 'Please fill all the fields');
    } else if (RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(_emailController.text) ==
        false) {
      CustomDialogs.showErrorSnackBar(
        context,
        'Please enter a valid email address',
      );
    } else {
      EasyLoading.show();
      final user = await AuthController().signInUser(
        context: context,
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      
      if (user != null){
        final userModel = await UserController().getUserData();
        if(userModel != null){
          Provider.of<UserProvider>(context, listen: false)
              .setUserModel(userModel);  
        }
        NavigatorManage.goPushReplace(context, HomeScreen());
      }
      EasyLoading.dismiss();

    }
  }
}
