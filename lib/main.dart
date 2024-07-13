import 'dart:math';
import 'package:flutter/material.dart';
import 'package:EasyPick/screen/main_screen.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EasyPick',
      home: MainScreen()
    );
  }
}