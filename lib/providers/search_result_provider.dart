import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class SearchResultProvider with ChangeNotifier {
  //String _displayText = "";
  bool wait = false;
  String _searchResultJsonResonse = "";
  bool _isFetchingSearchResults = false;

  String get getResponseText => _searchResultJsonResonse;
  bool get isFetching => _isFetchingSearchResults;

  Future<void> fetchData(String searchUrl) async {
    print(searchUrl);
    //  _isFetchingSearchResults = true;
    //notifyListeners();
    _isFetchingSearchResults = true;
    final response = await http.get(Uri.parse(searchUrl));
    if (response.statusCode == 200) {
      _searchResultJsonResonse = response.body;
    }
    print(response.statusCode);
    //_isFetchingSearchResults = false;
    _isFetchingSearchResults = true;
    notifyListeners();
  }

  //void setDisplayText(String text) {
  //_displayText = text;
  //notifyListeners();
  //}

  // String get getDisplayText => _displayText;
  List<dynamic> getResponseJson() {
    if (_searchResultJsonResonse.isNotEmpty) {
      Map<String, dynamic> json = jsonDecode(_searchResultJsonResonse);
      print(json['response']['sections'][0]['hits']);

      return json['response']['sections'][0]['hits'];
    }
    return [];
  }
}
