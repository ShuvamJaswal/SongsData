import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:song_app/providers/lyrics_provider.dart';

class LyricScreen extends StatefulWidget {
  final String lyricsURL;
  LyricScreen(this.lyricsURL);
  @override
  _LyricScreenState createState() => _LyricScreenState();
}

class _LyricScreenState extends State<LyricScreen> {
  var _isInit = true;
  var _isLoading = false;
  @override
  void initState() {
    //can use future.delayed(zero).then.providerFunctiontogeetdata
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      final songDataProvider = Provider.of<LyricsProvider>(context);
      await songDataProvider.fetchData("${widget.lyricsURL}");
      setState(() {
        _isLoading = false;
      });
      _isInit = false;
      super.didChangeDependencies();
    }
  }

  @override
  Widget build(BuildContext context) {
    final lyricsProvider = Provider.of<LyricsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lyrics',
        ),
      ),
      body: lyricsProvider.somethingIsntGood
          ? AlertDialog(
              title: Text("Something Went Wrong."),
            )
          : _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      lyricsProvider.getLyrics,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
    );
  }
}
