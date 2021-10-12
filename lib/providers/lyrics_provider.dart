import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

class LyricsProvider with ChangeNotifier {
  String _parsedLyrics = "";
  bool _somethingIsntGood =
      false; //to store if there is some problem in data processing.
  Future<void> fetchData(String songUrl) async {
    _somethingIsntGood = false;
    try {
      var response = await http.get(Uri.parse(songUrl));
      if (response.statusCode == 200) {
        var document = parse(response.body.replaceAll('<br/>', '\n'));
        try {
          _parsedLyrics = document
              .querySelectorAll("[class*='Lyrics__Root'],div.lyrics")[0]
              .text
              .trim();
          print(_parsedLyrics);
          notifyListeners();
        } catch (exception) {
          print(exception);
          _parsedLyrics = "Something went wrong";
        }
      } else {
        _somethingIsntGood = true;
        notifyListeners();
      }
    } catch (error) {
      _somethingIsntGood = true; //to show error dialog.
      notifyListeners();
    }
  }

  String get getLyrics => _parsedLyrics;
  bool get somethingIsntGood => _somethingIsntGood;
}
