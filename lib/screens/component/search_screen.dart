import 'package:diginfo/screens/main_screen.dart';
import "package:eva_icons_flutter/eva_icons_flutter.dart";
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diginfo/bloc/diginfo_bloc.dart';
import 'package:diginfo/elements/element.dart';
import 'package:diginfo/model/artikel.dart';
import 'package:diginfo/model/model_response.dart';
import 'package:diginfo/theme/theme.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'detail_berita.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getSearchBloc..getSearch("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: theme.accentColor,
              elevation: 2,
              centerTitle: false,
              actions: [
                IconButton(
                  tooltip: 'Back',
                  icon: Icon(Icons.arrow_back_ios_rounded),
                  onPressed: () {
                    //Take control back to previous page
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainScreen()));
                  },
                )
              ],
              title: new Text(
                "Diginfo.",
                style: TextStyle(
                  fontFamily: "Ambit",
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  letterSpacing: -1,
                ),
              ))),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
            child: TextFormField(
              style: TextStyle(fontSize: 14.0, color: Colors.black),
              controller: _searchController,
              onChanged: (changed) {
                getSearchBloc..getSearch(_searchController.text);
              },
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                filled: true,
                fillColor: Colors.grey[100],
                suffixIcon: _searchController.text.length > 0
                    ? IconButton(
                        icon: Icon(
                          EvaIcons.backspaceOutline,
                          color: Colors.grey[500],
                          size: 16.0,
                        ),
                        onPressed: () {
                          setState(() {
                            FocusScope.of(context).requestFocus(FocusNode());
                            _searchController.clear();
                            getSearchBloc..getSearch(_searchController.text);
                          });
                        })
                    : Icon(
                        EvaIcons.searchOutline,
                        color: Colors.grey[500],
                        size: 16.0,
                      ),
                enabledBorder: OutlineInputBorder(
                    borderSide: new BorderSide(
                        color: Colors.grey[100].withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(30.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: new BorderSide(
                        color: Colors.grey[100].withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(30.0)),
                contentPadding: EdgeInsets.only(left: 15.0, right: 10.0),
                labelText: "Search...",
                hintStyle: TextStyle(
                    fontSize: 14.0,
                    color: theme.accentColor,
                    fontWeight: FontWeight.w500),
                labelStyle: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500),
              ),
              autocorrect: false,
              autovalidateMode: AutovalidateMode.always,
            ),
          ),
          Expanded(
              child: StreamBuilder<ArtikelResponse>(
            stream: getSearchBloc.subject.stream,
            builder: (context, AsyncSnapshot<ArtikelResponse> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.error != null &&
                    snapshot.data.error.length > 0) {
                  return Container();
                }
                return _buildSourceNewsWidget(snapshot.data);
              } else if (snapshot.hasError) {
                return buildErrorWidget(snapshot.error);
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
    List<Artikel> articles = data.artikel;

    if (articles.length == 0) {
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
      return ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailBerita(
                              artikel: articles[index],
                            )));
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey[200], width: 1.0),
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
                          Text(articles[index].judul,
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
                                            articles[index].date)),
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
                            image: articles[index].img == null
                                ? AssetImage("assets/img/placeholder.jpg")
                                : articles[index].img,
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
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }
}
