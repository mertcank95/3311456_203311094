class GameModel {
  final String gameName;
  final String gameContent;
  final String gameType;
  final String gameDate;

  GameModel(this.gameName, this.gameContent, this.gameType, this.gameDate);

  @override
  String toString() {
    // TODO: implement toString
    return "${this.gameName} ${this.gameContent} ${this.gameType} ${this.gameDate}";
  }
}
