// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:wallpapershub/views/home.dart';
// import 'package:wallpaper/views/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(


      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: 'Wallpaper Hub',
      home: Home(),
    );
  }
}

