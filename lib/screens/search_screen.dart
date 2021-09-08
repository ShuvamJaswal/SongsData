import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/search_result_provider.dart';
import '../widgets/search_result_container.dart';

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
    var _isSearching = false;
    return Row(
      children: [
        Expanded(
          child: TextField(
            //    onChanged: (String fieldText) => searchResult.fetchData(
            //        'https://genius.com/api/search/song?q=${fieldText.trim()}'),
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
        Center(
          child: _isSearching
              ? CircularProgressIndicator()
              : SearchIconButton(
                  searchFieldInputController: searchFieldInputController),
        )
      ],
    );
  }
}

class SearchIconButton extends StatelessWidget {
  const SearchIconButton({
    required this.searchFieldInputController,
  });

  final TextEditingController searchFieldInputController;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          String fieldText = searchFieldInputController.text;
          print(fieldText);
          if (fieldText.trim().length != 0) {
            Provider.of<SearchResultProvider>(context, listen: false).fetchData(
                'https://genius.com/api/search/song?q=${fieldText.trim()}');
          }
        },
        icon: Icon(
          Icons.search,
          color: Theme.of(context).accentColor,
        ));
  }
}
