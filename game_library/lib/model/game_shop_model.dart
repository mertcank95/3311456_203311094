class GameShopModel {
  final String name;
  final double money;

  GameShopModel(this.name, this.money);
  @override
  String toString() {
    // TODO: implement toString
    return this.name + " " + this.money.toString();
  }
}
