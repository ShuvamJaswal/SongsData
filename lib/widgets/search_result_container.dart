import 'package:flutter/material.dart';
import '../providers/search_result_provider.dart';
import 'package:provider/provider.dart';

import '../screens/song_data.dart';

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
            ? Center(child: CircularProgressIndicator())
            : searchResults.shouldShowResultContainer
                ? searchResults.getResponseJson().length == 0
                    ? Text("Nothing Found")
                    : SingleChildScrollView(
                        child: ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: searchResults.getResponseJson().length,
                          itemBuilder: (context, index) {
                            return ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SongData(
                                              searchResults
                                                      .getResponseJson()[index]
                                                  ['result']['id'])));
                                },
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(searchResults
                                          .getResponseJson()[index]['result']
                                      ['song_art_image_thumbnail_url']),
                                ),
                                title: Text(
                                  searchResults.getResponseJson()[index]
                                      ['result']['full_title'],
                                ));
                          },
                        ),
                      )
                : Text("Please Enter Something To Search"),
      ),
    );
  }
}
