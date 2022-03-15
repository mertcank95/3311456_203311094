import 'package:flutter/material.dart';
import 'package:game_library/constants/constants.dart';
import 'package:game_library/model/game_about_model.dart';

class GameAboutDetail extends StatefulWidget {
  final GameAboutModel selectedGameAbout;
  GameAboutDetail({required this.selectedGameAbout, Key? key})
      : super(key: key);

  @override
  State<GameAboutDetail> createState() => _GameAboutDetailState();
}

class _GameAboutDetailState extends State<GameAboutDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: ConstantsStyles.appBarColor,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                widget.selectedGameAbout.gameName,
                style: ConstantsStyles.titleStyle,
              ),
              background: Image.asset(
                "assets/images/" + widget.selectedGameAbout.gameImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                  child: Text(
                widget.selectedGameAbout.gameContent,
                style: ConstantsStyles.textStyle,
              )),
            ),
          )
        ],
      ),
    );
  }
}
