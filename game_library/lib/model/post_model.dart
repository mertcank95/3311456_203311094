import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? id;
  String? post;
  String? gmail;
  String? userId;

  PostModel({this.id, this.post, this.gmail, this.userId});

  factory PostModel.fromSnapShot(DocumentSnapshot snapshot) {
    return PostModel(
      id: snapshot.id,
      post: snapshot["post"],
      gmail: snapshot["gmail"],
      userId: snapshot["userId"],

    );
  }
}
