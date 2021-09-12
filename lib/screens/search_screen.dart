import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:song_app/providers/search_result_provider.dart';
import 'package:song_app/widgets/search_result_container.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Song Data',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [SearchFieldEdit(), SearchResultContainer()],
        ),
      ),
    );
  }
}

class SearchFieldEdit extends StatelessWidget {
  final searchFieldInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searchResult = Provider.of<SearchResultProvider>(context);
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: (String fieldText) => searchResult.fetchData(
                'https://genius.com/api/search/song?q=${fieldText.trim()}'),
            onSubmitted: (String fieldText) => searchResult.fetchData(
                'https://genius.com/api/search/song?q=${fieldText.trim()}'),
            controller: searchFieldInputController,
            autofocus: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              labelText: "Enter Term to search.",
            ),
          ),
        ),
      ],
    );
  }
}
