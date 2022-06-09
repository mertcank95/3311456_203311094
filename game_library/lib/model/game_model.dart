import 'package:cloud_firestore/cloud_firestore.dart';

class GameModel {
  final String? id;
  final String? userId;
  final String? gameName;
  final String? gameContent;
  final String? gameType;
  final String? gameDate;

  GameModel(
      {this.id,
      this.userId,
      this.gameName,
      this.gameContent,
      this.gameType,
      this.gameDate});

  factory GameModel.fromSnapShot(DocumentSnapshot snapshot) {
    return GameModel(
        id: snapshot.id,
        userId: snapshot["userId"],
        gameName: snapshot["gameName"],
        gameContent: snapshot["gameContent"],
        gameType: snapshot["gameType"],
        gameDate: snapshot["gameDate"]);
  }
}
