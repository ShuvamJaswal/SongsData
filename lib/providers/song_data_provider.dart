import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:song_app/helpers/sond_data_model.dart';

class SongDataProvider with ChangeNotifier {
  String _searchResultJsonResonse = "";

  Future<void> fetchData(String songUrl) async {
    print(songUrl);
    var response = await http.get(Uri.parse(songUrl));
    if (response.statusCode == 200) {
      _searchResultJsonResonse = response.body;
    }
    //print(response.statusCode);
  }

  SongDataModel get getSongDataModel =>
      SongDataModel.fromJson(jsonDecode(_searchResultJsonResonse));
}
