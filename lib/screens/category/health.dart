import 'package:diginfo/widgets/hot_news.dart';
import 'package:diginfo/widgets/top_channel.dart';
import 'package:flutter/material.dart';
import 'package:diginfo/widgets/headline_slider_cat.dart';

class Health extends StatefulWidget {
  @override
  _HealthState createState() => _HealthState();
}

class _HealthState extends State<Health> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HeadlineSliderCat(
          category: "health",
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
        TopChannelsWidget(
          category: "health",
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
        HotNewsWidget(
          query: "health",
        ),
      ],
    );
  }
}
