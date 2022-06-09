import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:game_library/model/user_model.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  signOut() async {
    return await _auth.signOut();
  }

  Future<bool> createPerson(UserModel newUser) async {
    try {
      var user = await _auth.createUserWithEmailAndPassword(
          email: newUser.gmail!, password: newUser.password!);

      await _firestore.collection("Users").doc(user.user!.uid).set({
        "userName": newUser.name,
        "userSurName": newUser.surName,
        "email": newUser.gmail
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }
}
