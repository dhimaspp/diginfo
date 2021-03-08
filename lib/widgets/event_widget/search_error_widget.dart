import 'package:flutter/material.dart';

class SearchErrorWidget extends StatelessWidget {
  final String? tittle;
  const SearchErrorWidget({Key? key, this.tittle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.error_outline, color: Colors.red[300], size: 80.0),
          Container(
            padding: EdgeInsets.only(top: 16.0),
            child: Text(
              tittle!,
              style: TextStyle(
                color: Colors.red[300],
              ),
            ),
          )
        ],
      ),
    );
  }
}
