import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:game_library/model/personal_model.dart';
import 'package:path_provider/path_provider.dart';

class FileStorageServices {
  _getFilePath() async {
    var filePath = await getApplicationDocumentsDirectory();
    return filePath.path;
  }

  FileStorageServices() {
    _createFile();
  }

  Future<File> _createFile() async {
    var file = File(await _getFilePath() + "/data.txt");
    return file;
  }

  Future<void> dataInsert(PersonalModel personal) async {
    var file = await _createFile();
    await file.writeAsString(jsonEncode(personal.toJson()));
  }

  Future<PersonalModel> dataRead() async {
    try {
      var file = await _createFile();
      var fileContent = await file.readAsString();
      var json = jsonDecode(fileContent);
      return PersonalModel.fromJson(json);
    } catch (e) {
      debugPrint(e.toString());
    }
    return PersonalModel(
      "",
      "",
      [],
    );
  }
}
