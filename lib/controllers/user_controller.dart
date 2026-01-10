import 'package:abans_online/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/web.dart';

class UserController {
  //for User Collection
  final userCollection = FirebaseFirestore.instance.collection('Users');

  Future<bool> saveUserData(UserModel user) async {
    try {
      await userCollection.doc(user.uid).set(user.toJson());
      return true;
    } catch (error) {
      Logger().e(error);
      return false;
    }
  }

  Future<UserModel?> getUserData() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      final data = await userCollection.doc(uid).get();
      if (data.data() != null) {
        return UserModel.fromJson(data.data()!);
      }
      return null;
    } catch (error) {
      return null;
    }
  }
}
