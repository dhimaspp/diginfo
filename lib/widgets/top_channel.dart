import "package:carousel_slider/carousel_slider.dart";
import 'package:diginfo/model/sumber.dart';
import 'package:diginfo/screens/component/detail_sumber.dart';
import 'package:flutter/material.dart';
import 'package:diginfo/bloc/simple_version/diginfo_bloc.dart';
import 'package:diginfo/elements/element.dart';
import 'package:diginfo/model/model_response.dart';
import 'package:diginfo/screens/component/detail_berita.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:diginfo/theme/theme.dart';

class TopChannelsWidget extends StatefulWidget {
  final String category;
  const TopChannelsWidget({required this.category});
  @override
  _TopChannelsWidgetState createState() =>
      _TopChannelsWidgetState(category: category);
}

class _TopChannelsWidgetState extends State<TopChannelsWidget> {
  final String category;
  _TopChannelsWidgetState({required this.category});
  @override
  void initState() {
    super.initState();
    getSumber..getSumber(category);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SumberResponse>(
      stream: getSumber.subject.stream,
      builder: (context, AsyncSnapshot<SumberResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.error != null && snapshot.data!.error.length > 0) {
            return BuildErrorWidget(tittle: "terjadi kesalahan");
          }
          return _buildSourcesWidget(snapshot.data!);
        } else if (snapshot.hasError) {
          return BuildErrorWidget(tittle: "terjadi kesalahan");
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildSourcesWidget(SumberResponse data) {
    List<Sumber> sumber = data.sumber;
    if (sumber.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "Tidak ada sumber lagi",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else
      return Container(
        height: 115.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: sumber.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(top: 10.0, right: 0.0),
              width: 80.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SumberDetail(
                                sumber: sumber[index],
                              )));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Hero(
                      tag: sumber[index].id!,
                      child: Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5.0,
                                spreadRadius: 1.0,
                                offset: Offset(
                                  1.0,
                                  1.0,
                                ),
                              )
                            ],
                            image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    "assets/logos/${sumber[index].id}.png")),
                          )),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      sumber[index].namaSumber!,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1.4,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 10.0),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      sumber[index].category!,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1.4,
                          color: theme.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 9.0),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
  }
}
