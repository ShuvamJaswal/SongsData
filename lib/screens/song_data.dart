import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:song_app/helpers/sond_data_model.dart';
import 'package:song_app/providers/song_data_provider.dart';

class SongData extends StatefulWidget {
  final int songId;
  SongData(this.songId);
  @override
  _SongDataState createState() => _SongDataState();
}

class _SongDataState extends State<SongData> {
  var _isInit = true;
  var songData;
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
      final songDataProvider = Provider.of<SongDataProvider>(context);
      // Provider.of<SongDataProvider>(context)
      await songDataProvider
          .fetchData("https://genius.com/api/songs/${widget.songId}");
      songData = songDataProvider.getSongDataModel;
      // songData =
      //     SongDataModel.fromJson(jsonDecode(songDataProvider.getResponseText));

      print('SongID ${songData.id}');
      print('title ${songData.title}');
      print('album ${songData.album}');
      print('artist ${songData.artist}');
      setState(() {
        _isLoading = false;
      }); //.then((_) {
      //   setState(() {
      //     _isLoading = false;
      //   });
      // });
//aSYNC CALL
//
//

      //genius.com/api/search/song?q=${fieldText.trim()
      // Future.delayed(
      //   Duration(seconds: 2),
      // ).then((_) {
      //   setState(() {
      //     _isLoading = false;
      //   });
      // });

      super.didChangeDependencies();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Data"),
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Column(children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        clipBehavior: Clip.antiAlias,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width * 0.85,
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Stack(
                            children: [
                              Image(
                                image: NetworkImage(songData.imageUrl),
                                fit: BoxFit.cover,
                                height:
                                    MediaQuery.of(context).size.width * 0.85,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Text(widget.songId.toString()),

                      //  SingleChildScrollView(child: Text(songData)
                      //Text(Provider.of<SongDataProvider>(context).getResponseText)
                      // )
                      //,
                    ]),
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35, 5, 35, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        /// Title container
                        Text(
                          songData.title,
                          textAlign: TextAlign.center,
                          //overflow: TextOverflow.,
                          //maxLines: 1,
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).accentColor),
                        ),
                        Text(
                          songData.artist,
                          textAlign: TextAlign.center,
                          //overflow: TextOverflow.,
                          //maxLines: 1,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).accentColor),
                        ),
                      ],
                    ),
                  )
                ])
              ])));
  }
}
