import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class SearchResultProvider with ChangeNotifier {
  bool _somethingIsntGood =
      false; //to store if there is some problem in data processing.
  String _searchResultJsonResonse = ""; //save search response
  bool _isFetchingSearchResults = false; //see if request completed or not
  bool showResultContainer = false; //should show the search results or not

  Future<void> fetchData(String searchUrl) async {
    _somethingIsntGood = false; //reset variable value.
    _isFetchingSearchResults =
        true; //check if request is running or not, used for showling loading indicator.
    notifyListeners();
    try {
      var response = await http.get(Uri.parse(searchUrl));
      if (response.statusCode == 200) {
        _searchResultJsonResonse = response.body;
      }
    } catch (error) {
      _somethingIsntGood = true; //to show error dialog.
      notifyListeners();
    }
    _isFetchingSearchResults = false;
    notifyListeners();
  }

  void changeShowResults(bool choice) {
    showResultContainer = choice;
    notifyListeners();
  }

  List<dynamic> getResponseJson() {
    try {
      _somethingIsntGood = false;
      if (_searchResultJsonResonse.isNotEmpty) {
        Map<String, dynamic> json = jsonDecode(_searchResultJsonResonse);
        return json['response']['sections'][0]['hits'];
      }
    } catch (error) {
      _somethingIsntGood = true;
    }
    return [];
  }

//getters.
  bool get isFetching => _isFetchingSearchResults;
  String get getResponseText => _searchResultJsonResonse;
  bool get shouldShowResults {
    return showResultContainer;
  }

  bool get somethingIsntGood => _somethingIsntGood;
}
