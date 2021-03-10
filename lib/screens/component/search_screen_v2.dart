import 'package:diginfo/bloc/simple_version/diginfo_bloc.dart';
import 'package:diginfo/screens/main_screen.dart';
import 'package:diginfo/widgets/event_widget/search_error_widget.dart';
import 'package:diginfo/widgets/event_widget/search_loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diginfo/model/artikel.dart';
import 'package:diginfo/model/model_response.dart';
import 'package:diginfo/theme/theme.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'detail_berita.dart';

class SearchScreenV2 extends StatefulWidget {
  final GetSearchBloc? bloc;
  // final String searchController;
  SearchScreenV2({Key? key, this.bloc}) : super(key: key);
  @override
  _SearchScreenV2State createState() => _SearchScreenV2State();
}

class _SearchScreenV2State extends State<SearchScreenV2> {
  final _searchController = TextEditingController();
  // _SearchScreenState ({@required this.searchController});
  @override
  void initState() {
    super.initState();
    getSearchBloc..search('jokowi');
  }

  // @override
  // void dispose() {
  //   bloc.dispose();
  //   super.dispose();
  // }

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
                onChanged: (change) {
                  getSearchBloc..search(_searchController.text);
                },
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: true,
                  fillColor: Colors.grey[100],
                  suffixIcon: _searchController.text.length > 0
                      ? IconButton(
                          icon: Icon(
                            Icons.backspace_outlined,
                            color: Colors.grey[500],
                            size: 16.0,
                          ),
                          onPressed: () {
                            setState(() {
                              FocusScope.of(context).requestFocus(FocusNode());
                              _searchController.clear();
                              getSearchBloc..search(_searchController.text);
                            });
                          })
                      : Icon(
                          Icons.search_outlined,
                          color: Colors.grey[500],
                          size: 16.0,
                        ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: new BorderSide(
                          color: Colors.grey[100]!.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(30.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: new BorderSide(
                          color: Colors.grey[100]!.withOpacity(0.3)),
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
                autovalidateMode: AutovalidateMode.disabled),
          ),
          Expanded(
              child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: StreamBuilder<ArtikelResponse>(
                      stream: getSearchBloc.result,
                      builder: (BuildContext context,
                          AsyncSnapshot<ArtikelResponse> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.error != null &&
                              snapshot.data!.error.length > 0) {
                            return SearchErrorWidget(
                              tittle: "error",
                            );
                          }
                          return _buildSourceNewsWidget(snapshot.data!);
                        } else if (snapshot.hasError) {
                          return SearchErrorWidget(
                            tittle: "error aja",
                          );
                        } else {
                          return LoadingWidget();
                        }
                      }
                      // final state = snapshot.data;

                      // if (state == null) {
                      //   return SearchIntro();
                      // }
                      // if (state is SearchNoTerm) {
                      //   return SearchIntro();
                      // } else if (state is SearchEmpty) {
                      //   return EmptyWidget();
                      // } else if (state is SearchLoading) {
                      //   return LoadingWidget();
                      // } else if (state is SearchError) {
                      //   return SearchErrorWidget();
                      // } else if (state is SearchPopulated) {
                      //   return _buildSourceNewsWidget(state.result.artikel);
                      // }
                      // // } else if (snapshot.hasData){
                      // //   return _buildSourceNewsWidget(snapshot.data);
                      // // }

                      // throw Exception(
                      //     '${state.runtimeType} is not supported');
                      // return _buildChild(state);
                      )))
        ],
      ),
    );
  }

  Widget _buildSourceNewsWidget(ArtikelResponse artikel) {
    List<Artikel> data = artikel.artikel;
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailBerita(
                            artikel: data[index],
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
                        Text(data[index].judul!,
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
                                      timeUntil(
                                          DateTime.parse(data[index].date!)),
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
                          image: data[index].img == null
                              ? "https://via.placeholder.com/150"
                              : data[index].img!,
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
