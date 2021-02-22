import 'package:flutter/material.dart';
import 'package:diginfo/bloc/diginfo_bloc.dart';
import 'package:diginfo/elements/element.dart';
import 'package:diginfo/model/artikel.dart';
import 'package:diginfo/model/model_response.dart';
import 'package:diginfo/screens/component/detail_berita.dart';
import 'package:diginfo/theme/theme.dart';
import 'package:timeago/timeago.dart' as timeago;

class HotNewsWidget extends StatefulWidget {
  final String query;
  const HotNewsWidget({@required this.query});
  @override
  _HotNewsWidgetState createState() => _HotNewsWidgetState(query: query);
}

class _HotNewsWidgetState extends State<HotNewsWidget> {
  final String query;
  _HotNewsWidgetState({@required this.query});
  @override
  void initState() {
    super.initState();
    getHotNewsBloc..getHotNews(query);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ArtikelResponse>(
      stream: getHotNewsBloc.subject.stream,
      builder: (context, AsyncSnapshot<ArtikelResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return buildErrorWidget(snapshot.data.error);
          }
          return _buildHotNewsWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return buildErrorWidget(snapshot.error);
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildHotNewsWidget(ArtikelResponse data) {
    List<Artikel> artikel = data.artikel;

    if (artikel.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "No more news",
              style: TextStyle(color: Colors.black45),
            ),
          ],
        ),
      );
    } else
      return Container(
        height: artikel.length / 2 * 210.0,
        padding: EdgeInsets.all(5.0),
        child: new GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: artikel.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.85),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailBerita(
                                artikel: artikel[index],
                              )));
                },
                child: Container(
                  width: 220.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[100],
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                        offset: Offset(
                          1.0,
                          1.0,
                        ),
                      )
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(5.0)),
                              image: DecorationImage(
                                  image: artikel[index].img == null
                                      ? AssetImage("aseets/img/placeholder.jpg")
                                      : NetworkImage(artikel[index].img),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 15.0, bottom: 15.0),
                        child: Text(
                          artikel[index].judul,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(height: 1.3, fontSize: 15.0),
                        ),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            width: 180,
                            height: 1.0,
                            color: Colors.black12,
                          ),
                          Container(
                            width: 30,
                            height: 3.0,
                            color: theme.accentColor,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              artikel[index].sumber.namaSumber,
                              style: TextStyle(
                                  color: theme.accentColor, fontSize: 9.0),
                            ),
                            Text(
                              timeUntil(DateTime.parse(artikel[index].date)),
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 9.0),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
  }

  String timeUntil(DateTime date) {
    timeago.setLocaleMessages('id', timeago.IdMessages());
    return timeago.format(date, allowFromNow: true, locale: 'id');
  }
}
