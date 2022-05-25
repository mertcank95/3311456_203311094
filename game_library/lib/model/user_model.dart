import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? name;
  String? surName;
  String? gmail;
  String? password;

  UserModel({this.name, this.surName, this.gmail, this.password});
  UserModel.empty();
  factory UserModel.fromSnapShot(DocumentSnapshot snapshot) {
    return UserModel(
        name: snapshot["userName"],
        surName: snapshot["userSurName"],
        gmail: snapshot["email"]);
  }
}
