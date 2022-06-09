import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game_library/model/game_model.dart';
import 'package:game_library/model/post_model.dart';
import 'package:game_library/model/shop_fire_model.dart';

class FireStorageServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<PostModel> addPost(String post, String gmail, String userId) async {
    var ref = _firestore.collection("Post");

    var documentRef =
        await ref.add({'post': post, 'gmail': gmail, 'userId': userId});

    return PostModel(id: documentRef.id, post: post, userId: userId);
  }

//veri çekme
  Stream<QuerySnapshot> getPost() {
    var ref = _firestore.collection("Post").snapshots();
    return ref;
  }

  Stream<QuerySnapshot> getCurrentUserPost(String userId) {
    var docm = _firestore
        .collection("Post")
        .where("userId", isEqualTo: userId)
        .snapshots();
    return docm;
  }

//silme
  Future<void> removePost(String docId) {
    var ref = _firestore.collection("Post").doc(docId).delete();
    return ref;
  }

  Future<ShopFireModel> addShopList(ShopFireModel games) async {
    var ref = _firestore.collection("Shop");

    var documentRef = await ref.add({
      'userId': games.userId,
      'totalMoney': games.totalMoney,
      'games': games.games
    });

    return ShopFireModel(
        id: documentRef.id,
        userId: games.userId,
        totalMoney: games.totalMoney,
        games: games.games);
  }

  Stream<QuerySnapshot> getCurrentUserShopHistory(String userId) {
    var docm = _firestore
        .collection("Shop")
        .where("userId", isEqualTo: userId)
        .snapshots();
    return docm;
  }

  Future<GameModel> addGame(GameModel games) async {
    var ref = _firestore.collection("Game");

    var documentRef = await ref.add({
      'userId': games.userId,
      'gameName': games.gameName,
      'gameContent': games.gameContent,
      'gameType': games.gameType,
      'gameDate': games.gameDate
    });

    return GameModel(
        id: documentRef.id,
        userId: games.userId,
        gameName: games.gameName,
        gameType: games.gameType,
        gameContent: games.gameContent,
        gameDate: games.gameDate);
  }

  Stream<QuerySnapshot> getCurrentUserGame(String userId) {
    var docm = _firestore
        .collection("Game")
        .where("userId", isEqualTo: userId)
        .snapshots();
    return docm;
  }

  Future<void> removeGame(String docId) {
    var ref = _firestore.collection("Game").doc(docId).delete();
    return ref;
  }
}
