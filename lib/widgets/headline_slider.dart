import "package:carousel_slider/carousel_slider.dart";
import 'package:flutter/material.dart';
import 'package:diginfo/bloc/simple_version/diginfo_bloc.dart';
import 'package:diginfo/elements/element.dart';
import 'package:diginfo/model/artikel_response.dart';
import 'package:diginfo/model/artikel.dart';
import 'package:diginfo/screens/component/detail_berita.dart';
import 'package:timeago/timeago.dart' as timeago;

class HeadlineSlider extends StatefulWidget {
  @override
  _HeadlineSliderState createState() => _HeadlineSliderState();
}

class _HeadlineSliderState extends State<HeadlineSlider> {
  @override
  void initState() {
    super.initState();
    getTopHeadlinesGen..getTopHeadlinesGen();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ArtikelResponse>(
      stream: getTopHeadlinesGen.subject.stream,
      builder: (context, AsyncSnapshot<ArtikelResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return BuildErrorWidget(
              tittle: "terjadi kesalahan",
            );
          }
          return _buildHeadlineSliderWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return BuildErrorWidget(
            tittle: "terjadi kesalahan",
          );
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildHeadlineSliderWidget(ArtikelResponse data) {
    List<Artikel> artikel = data.artikel;
    return Container(
        child: CarouselSlider(
      options: CarouselOptions(
          enlargeCenterPage: true, height: 200.0, viewportFraction: 0.7),
      items: getExpenseSlider(artikel),
    ));
  }

  getExpenseSlider(List<Artikel> artikel) {
    return artikel
        .map((artikel) => GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailBerita(
                              artikel: artikel,
                            )));
              },
              child: Container(
                padding: const EdgeInsets.only(
                    left: 1.0, right: 1.0, top: 10.0, bottom: 10.0),
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: artikel.img == null
                                  ? AssetImage("assets/img/placeholder.jpg")
                                  : NetworkImage(artikel.img))),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [
                              0.1,
                              0.9
                            ],
                            colors: [
                              Colors.black.withOpacity(0.9),
                              Colors.white.withOpacity(0.0)
                            ]),
                      ),
                    ),
                    Positioned(
                        bottom: 30.0,
                        child: Container(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          width: 270.0,
                          child: Column(
                            children: <Widget>[
                              Text(
                                artikel.judul,
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0),
                              ),
                            ],
                          ),
                        )),
                    Positioned(
                        bottom: 10.0,
                        left: 10.0,
                        child: Text(
                          artikel.sumber.namaSumber,
                          style:
                              TextStyle(color: Colors.white54, fontSize: 9.0),
                        )),
                    Positioned(
                        bottom: 10.0,
                        right: 10.0,
                        child: Text(
                          timeUntil(DateTime.parse(artikel.date)),
                          style:
                              TextStyle(color: Colors.white54, fontSize: 9.0),
                        )),
                  ],
                ),
              ),
            ))
        .toList();
  }

  String timeUntil(DateTime date) {
    timeago.setLocaleMessages('id', timeago.IdMessages());
    return timeago.format(date, allowFromNow: true, locale: 'id');
  }
}
