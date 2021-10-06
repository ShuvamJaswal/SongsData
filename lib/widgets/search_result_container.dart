import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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
      child: searchResults
              .somethingIsntGood //if here is some error in data processing.
          ? AlertDialog(
              title: Text("Something Went Wrong."),
            )
          : Container(
              padding: const EdgeInsets.all(16.0),
              child: searchResults.isFetching
                  ? Center(child: CircularProgressIndicator())
                  : searchResults.shouldShowResults
                      ? searchResults.getResponseJson().length == 0
                          ? Text("Nothing Found")
                          : ListView.builder(
                              physics: const BouncingScrollPhysics(),
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
                                                          .getResponseJson()[
                                                      index]['result']['id'])));
                                    },
                                    leading: CircleAvatar(
                                      child: CachedNetworkImage(
                                        imageUrl: searchResults
                                                    .getResponseJson()[index]
                                                ['result']
                                            ['song_art_image_thumbnail_url'],
                                        placeholder: (context, url) => Center(
                                          child: Icon(
                                            MdiIcons.musicNoteOutline,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Center(
                                          child: Icon(
                                            MdiIcons.musicNoteOutline,
                                          ),
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      searchResults.getResponseJson()[index]
                                          ['result']['full_title'],
                                    ));
                              },
                            )
                      : Text("Please Enter Something To Search"),
            ),
    );
  }
}
