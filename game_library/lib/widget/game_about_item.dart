import 'package:flutter/material.dart';
import 'package:game_library/constants/constants.dart';
import 'package:game_library/model/game_about_model.dart';

class GameAboutItem extends StatelessWidget {
  final GameAboutModel selectGameAbout;
  const GameAboutItem({required this.selectGameAbout, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Card(
        shadowColor: Colors.blue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
            side: BorderSide(color: Colors.blue.shade100, width: 2)),
        elevation: 5,
        child: ListTile(
          leading: Image.asset("assets/images/" + selectGameAbout.gameIcon),
          onTap: () {
            Navigator.pushNamed(context, "/gameAboutDetail",
                arguments: selectGameAbout);
          },
          title: Text(
            selectGameAbout.gameName,
            style: ConstantsStyles.newsTitle,
          ),
          subtitle: Text("Oyun çıkış tarihi : " + selectGameAbout.gameDate),
          trailing: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}
