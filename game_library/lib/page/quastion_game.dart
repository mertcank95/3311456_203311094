import 'package:flutter/material.dart';
import 'package:game_library/constants/constants.dart';
import 'package:polls/polls.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
            sliver: SliverList(
                delegate: SliverChildListDelegate([
              quastion(),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  child: _MyHomePage())
            ])),
          ),
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

class _MyHomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  _MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  List<_PollsData> data = [
    _PollsData('Elden Ring', 2),
    _PollsData('God Of War', 5),
    _PollsData('Dying light 2', 8),
    _PollsData('Grand Theft Auto V', 6),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      //Initialize the chart widget
      SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          // Chart title
          title: ChartTitle(text: ' analysis'),
          // Enable legend
          legend: Legend(isVisible: true),
          // Enable tooltip
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <ChartSeries<_PollsData, String>>[
            LineSeries<_PollsData, String>(
                dataSource: data,
                xValueMapper: (_PollsData game, _) => game.gameName,
                yValueMapper: (_PollsData game, _) => game.opt,
                name: 'Sales',
                // Enable data label
                dataLabelSettings: const DataLabelSettings(isVisible: true))
          ]),
    ]));
  }
}

class _PollsData {
  _PollsData(this.gameName, this.opt);

  final String gameName;
  final double opt;
}
