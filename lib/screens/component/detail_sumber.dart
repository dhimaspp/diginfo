import 'package:diginfo/bloc/simple_version/diginfo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:diginfo/elements/element.dart';
import 'package:diginfo/model/artikel.dart';
import 'package:diginfo/model/artikel_response.dart';
import 'package:diginfo/model/sumber.dart';
import 'package:diginfo/theme/theme.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'detail_berita.dart';

class SumberDetail extends StatefulWidget {
  final Sumber sumber;
  SumberDetail({Key? key, required this.sumber}) : super(key: key);
  @override
  _SourceDetailState createState() => _SourceDetailState(sumber);
}

class _SourceDetailState extends State<SumberDetail> {
  final Sumber sumber;
  _SourceDetailState(this.sumber);
  @override
  void initState() {
    super.initState();
    getSumberBeritaBloc..getSumberBerita(sumber.id);
  }

  @override
  void dispose() {
    getSumberBeritaBloc.drainStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            centerTitle: false,
            elevation: 0.0,
            backgroundColor: theme.accentColor,
            title: new Text(
              "",
            )),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
            color: theme.accentColor,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Hero(
                  tag: sumber.id!,
                  child: SizedBox(
                      height: 80.0,
                      width: 80.0,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 2.0, color: Colors.white),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/logos/${sumber.id}.png"),
                                fit: BoxFit.cover)),
                      )),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  sumber.namaSumber!,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  sumber.deskripsi!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: StreamBuilder<ArtikelResponse>(
            stream: getSumberBeritaBloc.subject.stream,
            builder: (context, AsyncSnapshot<ArtikelResponse> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.error != null &&
                    snapshot.data!.error.length > 0) {
                  return BuildErrorWidget(
                    tittle: snapshot.data!.error,
                  );
                }
                return _buildSourceNewsWidget(snapshot.data!);
              } else if (snapshot.hasError) {
                return BuildErrorWidget(
                  tittle: snapshot.data!.error,
                );
              } else {
                return buildLoadingWidget();
              }
            },
          ))
        ],
      ),
    );
  }

  Widget _buildSourceNewsWidget(ArtikelResponse data) {
    List<Artikel> artikel = data.artikel;

    if (artikel.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Tidak ada berita lagi",
              style: TextStyle(color: Colors.black45),
            ),
          ],
        ),
      );
    } else
      return ListView.builder(
          itemCount: artikel.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailBerita(
                              artikel: artikel[index],
                            )));
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey[200]!, width: 1.0),
                  ),
                  color: Colors.white,
                ),
                height: 150,
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          top: 10.0, left: 10.0, bottom: 10.0, right: 10.0),
                      width: MediaQuery.of(context).size.width * 3 / 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(artikel[index].judul!,
                              maxLines: 3,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 14.0)),
                          Expanded(
                              child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                        timeUntil(DateTime.parse(
                                            artikel[index].date!)),
                                        style: TextStyle(
                                            color: Colors.black26,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.0))
                                  ],
                                ),
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(right: 10.0),
                        width: MediaQuery.of(context).size.width * 2 / 5,
                        height: 130,
                        child: FadeInImage.assetNetwork(
                            alignment: Alignment.topCenter,
                            placeholder: 'assets/img/placeholder.jpg',
                            image: artikel[index].img == null
                                ? AssetImage("assets/img/placeholder.jpg") as String
                                : artikel[index].img!,
                            fit: BoxFit.fitHeight,
                            width: double.maxFinite,
                            height: MediaQuery.of(context).size.height * 1 / 3))
                  ],
                ),
              ),
            );
          });
  }

  String timeUntil(DateTime date) {
    timeago.setLocaleMessages('id', timeago.IdMessages());
    return timeago.format(date, allowFromNow: true, locale: 'id');
  }
}
