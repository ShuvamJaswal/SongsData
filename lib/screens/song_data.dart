import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:song_app/providers/song_data_provider.dart';

class SongData extends StatefulWidget {
  final int songId;
  SongData(this.songId);
  @override
  _SongDataState createState() => _SongDataState();
}

class _SongDataState extends State<SongData> {
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
      final songData = Provider.of<SongDataProvider>(context);
      // Provider.of<SongDataProvider>(context)
      await songData.fetchData("https://genius.com/api/songs/${widget.songId}");
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
          : //Text(widget.songId.toString()),

          SingleChildScrollView(
              child:
                  Text(Provider.of<SongDataProvider>(context).getResponseText)),
    );
  }
}
