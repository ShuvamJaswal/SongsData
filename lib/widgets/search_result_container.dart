import 'package:flutter/material.dart';
import 'package:song_app/screens/song_data.dart';
import '../providers/search_result_provider.dart';
import 'package:provider/provider.dart';

class SearchResultContainer extends StatefulWidget {
  @override
  _SearchResultContainerState createState() => _SearchResultContainerState();
}

class _SearchResultContainerState extends State<SearchResultContainer> {
  @override
  Widget build(BuildContext context) {
    final searchResults = Provider.of<SearchResultProvider>(context);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: searchResults.isFetching
            ? CircularProgressIndicator()
            : searchResults.getResponseJson().length == 0
                ? Text("Please Enter Something To Search")
                : SingleChildScrollView(
                    child: ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SongData(
                                          searchResults.getResponseJson()[index]
                                              ['result']['id'])));
                            },
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(searchResults
                                      .getResponseJson()[index]['result']
                                  ['song_art_image_thumbnail_url']),
                            ),
                            title: Text(
                              searchResults.getResponseJson()[index]['result']
                                  ['full_title'],
                            ));
                      },
                    ),
                  ),
      ),
    );
  }
}
