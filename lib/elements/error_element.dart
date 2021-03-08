import 'package:flutter/material.dart';

class BuildErrorWidget extends StatelessWidget {
  const BuildErrorWidget({required this.tittle});
  final String tittle;
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            tittle,
            style: theme.textTheme.headline5,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
