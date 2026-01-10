import 'package:abans_online/controllers/user_controller.dart';
import 'package:abans_online/screens/home_screen.dart';
import 'package:abans_online/utils/navigator_manage.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  UserModel? get user => _user;

  void setUserModel(UserModel? userModel) {
    _user = userModel;
    notifyListeners();
  }


  Future<void> fetchUserData(BuildContext context) async {
    final userModel = await UserController().getUserData();
    if (userModel != null) {
      _user = userModel;
      NavigatorManage.goPushReplace(context, HomeScreen());
    }
  }
}
