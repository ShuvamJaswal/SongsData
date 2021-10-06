import 'package:flutter/material.dart';
import 'package:song_app/providers/song_data_provider.dart';
import '../providers/search_result_provider.dart';
import '../screens/search_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(SongDataApp());
}

class SongDataApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
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
