import 'package:diginfo/error_handler/api_repository.dart';
import 'package:diginfo/repository/repository.dart';
import 'package:diginfo/screens/main_screen.dart';
import 'package:diginfo/theme/theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // late DiginfoRepository? api;

  // MyApp({Key? key, this.api}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: theme.primaryColorDark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreen(),
    );
  }
}
