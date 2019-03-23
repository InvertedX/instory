import 'package:flutter/material.dart';
import 'package:stories/screens/home.dart';
import 'package:stories/utils/colors.dart';

void main() => runApp(StoriesApp());

class StoriesApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stories',
      theme: ThemeData(
          backgroundColor: background, scaffoldBackgroundColor: background),
      home: Home(),
    );
  }
}
