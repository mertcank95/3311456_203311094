import 'package:cloud_firestore/cloud_firestore.dart';

class ShopFireModel {
  String? id;
  String? userId;
  String? totalMoney;
  Map<String, String> games;

  ShopFireModel({this.id, this.userId, this.totalMoney, required this.games});

  factory ShopFireModel.fromSnapShot(DocumentSnapshot snapshot) {
    return ShopFireModel(
        id: snapshot.id,
        userId: snapshot['userId'],
        totalMoney: snapshot["totalMoney"],
        games: snapshot["games"]);
  }
}
