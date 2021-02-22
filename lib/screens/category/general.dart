import 'package:diginfo/widgets/headline_slider.dart';
import 'package:diginfo/widgets/hot_news.dart';
import 'package:diginfo/widgets/top_channel.dart';
import 'package:flutter/material.dart';

class General extends StatefulWidget {
  @override
  _GeneralState createState() => _GeneralState();
}

class _GeneralState extends State<General> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HeadlineSlider(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Text(
                "Top channels",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0),
              ),
            ],
          ),
        ),
        TopChannelsWidget(
          category: "general",
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Text(
                "Top channels",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0),
              ),
            ],
          ),
        ),
        HotNewsWidget(query: "indonesia"),
      ],
    );
  }
}
