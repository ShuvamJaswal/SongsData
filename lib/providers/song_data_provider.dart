import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:song_app/helpers/sond_data_model.dart';

class SongDataProvider with ChangeNotifier {
  String _songDataJsonResonse = "";
  bool _somethingIsntGood =
      false; //to store if there is some problem in data processing.
  Future<void> fetchData(String songUrl) async {
    _somethingIsntGood = false;
    try {
      var response = await http.get(Uri.parse(songUrl));
      if (response.statusCode == 200) {
        _songDataJsonResonse = response.body;
      }
    } catch (error) {
      _somethingIsntGood = true; //to show error dialog.
      notifyListeners();
    }
  }

  SongDataModel get getSongDataModel =>
      SongDataModel.fromJson(jsonDecode(_songDataJsonResonse));
  bool get somethingIsntGood => _somethingIsntGood;
}
