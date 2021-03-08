import 'package:diginfo/model/artikel.dart';
import "package:flutter/material.dart";
import 'package:flutter_html/flutter_html.dart';
import "package:timeago/timeago.dart" as timeago;
import 'package:diginfo/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailBerita extends StatefulWidget {
  final Artikel artikel;
  DetailBerita({Key? key, required this.artikel}) : super(key: key);
  @override
  _DetailBeritaState createState() => _DetailBeritaState(artikel);
}

class _DetailBeritaState extends State<DetailBerita> {
  final Artikel artikel;
  _DetailBeritaState(this.artikel);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: () {
          launch(artikel.url!);
        },
        child: Container(
          height: 48,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white, gradient: Gradiento.primaryGradient),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[Text("Baca Selanjutnya")],
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: theme.accentColor,
        title: Text(artikel.judul!),
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 9,
            child: FadeInImage.assetNetwork(
              alignment: Alignment.topCenter,
              placeholder: "assets/img/placeholder.jpg",
              image: artikel.img == null
                  ? AssetImage("assets/img/placeholder.jpg") as String
                  : artikel.img!,
              fit: BoxFit.cover,
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height * 1 / 3,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[Text(artikel.date!.substring(0, 10))],
                ),
                SizedBox(height: 10.0),
                GestureDetector(
                  onTap: () {},
                  child: Text(artikel.judul!),
                ),
                SizedBox(height: 10.0),
                Text(timeUntil(DateTime.parse(artikel.date!))),
                SizedBox(height: 10.0),
                Html(
                  data: artikel.content!,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  String timeUntil(DateTime date) {
    return timeago.format(date, allowFromNow: true);
  }
}
