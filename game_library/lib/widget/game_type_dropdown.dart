import 'package:flutter/material.dart';
import 'package:game_library/controller/data_controller.dart';

import '../constants/constants.dart';

class GameTypeDropdownWidget extends StatefulWidget {
  final Function onSelectDropDown;
  const GameTypeDropdownWidget({required this.onSelectDropDown, Key? key})
      : super(key: key);

  @override
  State<GameTypeDropdownWidget> createState() => _GameTypeDropdownWidget();
}

class _GameTypeDropdownWidget extends State<GameTypeDropdownWidget> {
  String selectGameType = "Aksiyon";
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: ConstantsStyles.textFormColor,
          borderRadius: BorderRadius.circular(20)),
      child: DropdownButton<String>(
        elevation: 16,
        iconEnabledColor: Colors.black,
        value: selectGameType,
        items: DataControl.gameTypeDropDown(),
        onChanged: (value) {
          setState(() {
            selectGameType = value!;
            widget.onSelectDropDown(selectGameType);
          });
        },
        underline: Container(),
      ),
    );
  }
}
