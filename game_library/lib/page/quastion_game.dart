// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:game_library/constants/constants.dart';
import 'package:polls/polls.dart';

class QuastionGame extends StatefulWidget {
  const QuastionGame({Key? key}) : super(key: key);

  @override
  State<QuastionGame> createState() => _QuastionGameState();
}

class _QuastionGameState extends State<QuastionGame> {
  double option1 = 3.0;
  double option2 = 1.0;
  double option3 = 2.0;
  double option4 = 0.0;

  String user = "king@mail.com";
  Map usersWhoVoted = {
    'a@mail.com': 3,
    'b@mail.com': 4,
    'c@mail.com': 1,
    'd@mail.com': 1
  };
  String creator = "mert@mail.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ConstantsStyles.appBarColor,
          title: Text(
            "Quastion",
            style: ConstantsStyles.titleStyle,
          )),
      // ignore: prefer_const_constructors
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(10),
            sliver: SliverList(delegate: SliverChildListDelegate([quastion()])),
          )
        ],
      ),
    );
  }

  Polls quastion() {
    return Polls(
      children: [
        Polls.options(title: 'Elden Ring', value: option1),
        Polls.options(title: 'God Of War', value: option2),
        Polls.options(title: 'Dying light 2', value: option3),
        Polls.options(title: 'Grand Theft Auto V', value: option4),
      ],
      question: Text(
        'Bu yıl en çok oynanacak oyun Sizce Hangisi ?',
        style: ConstantsStyles.textStyle,
      ),
      currentUser: user,
      creatorID: creator,
      voteData: usersWhoVoted,
      userChoice: usersWhoVoted[user],
      onVoteBackgroundColor: Colors.blue,
      leadingBackgroundColor: Colors.blue,
      backgroundColor: Colors.white,
      onVote: (choice) {
        setState(() {
          usersWhoVoted[user] = choice;
        });
        if (choice == 1) {
          setState(() {
            option1 += 1.0;
          });
        }
        if (choice == 2) {
          setState(() {
            option2 += 1.0;
          });
        }
        if (choice == 3) {
          setState(() {
            option3 += 1.0;
          });
        }
        if (choice == 4) {
          setState(() {
            option4 += 1.0;
          });
        }
      },
    );
  }
}
