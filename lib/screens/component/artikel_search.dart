import 'package:flutter/material.dart';

class ArtikelSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isNotEmpty
          ? IconButton(
              tooltip: 'Clear',
              icon: const Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            )
          : IconButton(
              icon: const Icon(Icons.mic),
              tooltip: 'Voice input',
              onPressed: () {
                this.query = 'TBW: Get input from voice';
              },
            ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        //Take control back to previous page
        this.close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
