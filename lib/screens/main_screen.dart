import 'package:diginfo/elements/loader.dart';
import 'package:diginfo/error_handler/api_repository.dart';
import 'package:diginfo/model/artikel.dart';
import 'package:diginfo/model/artikel_response.dart';
import 'package:diginfo/repository/repository.dart';
import 'package:diginfo/screens/category/category.dart';
import 'package:diginfo/screens/component/artikel_search.dart';
import 'package:diginfo/screens/component/search_screen.dart';
import 'package:diginfo/screens/component/search_screen_v2.dart';
import 'package:diginfo/theme/theme.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';

class MainScreen extends StatefulWidget {
  final ApiRepository api;

  MainScreen({Key key, this.api}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // final List<String> artikel;
  // SearchAppBarDelegate _searchAppBarDelegate;
  // ArtikelResponse artikelResponse;
  // _MainScreenState()
  //     : artikel = List.from(Set.from(getSearchBloc.getSearch('')))
  //         ..sort(
  //           (w1, w2) => w1.toLowerCase().compareTo(w2.toLowerCase()),
  //         ),
  //       super();
  // // TopBarBloc _topBarBloc;
  // void _showSearch(
  //     BuildContext context, SearchAppBarDelegate searchAppBarDelegate) async {
  //   final searchService = getSearchBloc..getSearch('');
  //   final user = await showSearch<ArtikelResponse>(
  //     context: context,
  //     delegate: _searchAppBarDelegate,
  //   );
  //   searchService.dispose();
  //   print(user);
  // }
  // final _searchController = TextEditingController();
  // @override
  // void initState() {
  //   super.initState();
  //   getSearchBloc..getSearch("");
  //   // _searchAppBarDelegate = SearchAppBarDelegate();
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.0),
            child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: theme.accentColor,
              elevation: 2,
              centerTitle: false,
              title: new Text(
                "Diginfo.",
                style: TextStyle(
                  fontFamily: "Ambit",
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  letterSpacing: -1,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchScreenV2(
                                  api: widget.api,
                                )));
                  },
                )
              ],
              bottom: TabBar(
                isScrollable: true,
                indicatorWeight: 6,
                indicatorColor: Colors.white,
                tabs: <Widget>[
                  Tab(text: "General"),
                  Tab(text: "Business"),
                  Tab(text: "Entertainment"),
                  Tab(text: "Health"),
                  Tab(text: "Science"),
                  Tab(text: "Sports"),
                  Tab(text: "Technology"),
                ],
              ),
            )),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(0),
            child: TabBarView(
              children: <Widget>[
                General(),
                Business(),
                Entertainment(),
                Health(),
                Science(),
                Sports(),
                Technology()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
