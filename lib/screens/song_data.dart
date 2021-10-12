import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:song_app/providers/song_data_provider.dart';
import 'package:song_app/screens/lyrics_screen.dart';
import 'package:url_launcher/url_launcher.dart';

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
      await songDataProvider
          .fetchData("https://genius.com/api/songs/${widget.songId}");
      songData = songDataProvider.getSongDataModel;
      setState(() {
        _isLoading = false;
      });
      _isInit = false;
      super.didChangeDependencies();
    }
  }

  @override
  Widget build(BuildContext context) {
    final songDataProvider = Provider.of<SongDataProvider>(
        context); //initialized again so thet it can be used in this scope the provider in isinit wont work because of different context ig.
    return Scaffold(
      appBar: AppBar(
        title: Text("Data"),
      ),
      body: songDataProvider.somethingIsntGood
          ? AlertDialog(
              title: Text("Something Went Wrong."),
            )
          : _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  padding: EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        clipBehavior: Clip.antiAlias,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.width * 0.85,
                          width: MediaQuery.of(context).size.width * 0.85,
                          imageUrl: songData.imageUrl,
                          placeholder: (context, url) => Center(
                            child: Icon(
                              MdiIcons.musicNoteOutline,
                              size: MediaQuery.of(context).size.width * 0.50,
                            ),
                          ),
                          errorWidget: (context, url, error) => Center(
                            child: Icon(
                              MdiIcons.musicNoteOutline,
                              size: MediaQuery.of(context).size.width * 0.50,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(35, 5, 35, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                /// Title container
                                Text(
                                  "Title: ${songData.title}",
                                  textAlign: TextAlign.left,
                                  //overflow: TextOverflow.,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    // color: Theme.of(context).accentColor
                                  ),
                                ),
                                Text(
                                  "Artist: ${songData.artist}",
                                  textAlign: TextAlign.left,
                                  //overflow: TextOverflow.,
                                  //maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                ),
                                Text("Release Date: ${songData.releaseDate}"),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    if (songData.youTubeUrl != null)
                                      IconButton(
                                        icon: Icon(
                                          MdiIcons.youtube,
                                          size: 40,
                                          color: Colors.red,
                                        ),
                                        onPressed: () =>
                                            launch(songData.youTubeUrl),
                                      ),
                                    if (songData.spotifyUrl != null)
                                      IconButton(
                                        icon: Icon(
                                          MdiIcons.spotify,
                                          size: 40,
                                          color: Colors.green,
                                        ),
                                        onPressed: () =>
                                            launch(songData.spotifyUrl),
                                      ),
                                    if (songData.soundCloudUrl != null)
                                      IconButton(
                                        icon: Icon(
                                          MdiIcons.soundcloud,
                                          size: 40,
                                          color: Colors.orange,
                                        ),
                                        onPressed: () =>
                                            launch(songData.soundCloudUrl),
                                      ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LyricScreen(songData.lyricsURL)));
                        },
                        child: Text("LYRICS"),
                      ),
                    ],
                  ),
                ),
    );
  }
}
