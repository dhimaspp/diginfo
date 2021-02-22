import 'package:diginfo/widgets/headline_slider_cat.dart';
import 'package:diginfo/widgets/hot_news.dart';
import 'package:diginfo/widgets/top_channel.dart';
import 'package:flutter/material.dart';

class Business extends StatefulWidget {
  @override
  _BusinessState createState() => _BusinessState();
}

class _BusinessState extends State<Business> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HeadlineSliderCat(category: "business",),
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
        TopChannelsWidget(category: "business",),
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
        HotNewsWidget(query: "business",),
      ],
    );
  }
}
