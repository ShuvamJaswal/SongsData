//todo probably working A little check update functionality in main.dart

import 'package:flutter/material.dart';
import 'package:song_app/providers/lyrics_provider.dart';
import 'package:song_app/providers/song_data_provider.dart';
import '../providers/search_result_provider.dart';
import '../screens/search_screen.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(SongDataApp());
}

class SongDataApp extends StatelessWidget {
  Future<String> getUpdate() async {
    try {
      var response = await http.get(Uri.parse(
          "https://raw.githubusercontent.com/ShuvamJaswal/SongsData/main/version_info.txt"));

      final String result = response.body;
      print(result);
      return result;
    } catch (e) {
      print("Check Update Error $e");
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    getUpdate();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LyricsProvider>(
          create: (_) => LyricsProvider(),
        ),
        ChangeNotifierProvider<SearchResultProvider>(
          create: (_) => SearchResultProvider(),
        ),
        ChangeNotifierProvider<SongDataProvider>(
          create: (_) => SongDataProvider(),
        ),
      ],
      child: MaterialApp(
        home: SearchScreen(),
        theme: ThemeData.dark().copyWith(
          appBarTheme: AppBarTheme(backgroundColor: Colors.black),
          scaffoldBackgroundColor: Colors.black,
        ),
      ),
    );
  }
}
