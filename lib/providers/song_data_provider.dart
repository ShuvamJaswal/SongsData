import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class SongDataProvider with ChangeNotifier {
  String _searchResultJsonResonse = "";

  Future<void> fetchData(String songUrl) async {
    print(songUrl);
    var response = await http.get(Uri.parse(songUrl));
    if (response.statusCode == 200) {
      _searchResultJsonResonse = response.body;
    }
    print(response.statusCode);
  }

  String get getResponseText => _searchResultJsonResonse;
//   List<dynamic> getResponseJson() {
//     if (_searchResultJsonResonse.isNotEmpty) {
//       // print(_searchResultJsonResonse);
//       Map<String, dynamic> json = jsonDecode(_searchResultJsonResonse);
//       print(json['response']['sections'][0]['hits']);
//       // print(json['data']['avatar']);
//       return json['response']['sections'][0]['hits'];
//     }
//     return [];
//   }
}
