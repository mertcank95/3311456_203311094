class PersonalModel {
  final String name;
  final String mail;
  final List<String> games;

  PersonalModel(this.name, this.mail, this.games);

  Map<String, dynamic> toJson() {
    return {"name": name, "mail": mail, "games": games};
  }

  PersonalModel.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        mail = json["mail"],
        games = List<String>.from(json["games"]);
}
