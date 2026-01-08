import 'package:flutter/material.dart';
import 'package:my_app/body.dart';
import 'package:my_app/components/appbar.dart';
import 'package:my_app/pages/HomeScreen.dart';
import 'package:my_app/pages/allTopics_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: SimpleAppBar(title: "Dashboard"),
        body: Homescreen(text: "Home Screen"),
        // body: Body(text: "Home Page"),
        // body: AllTopicsScreen(navbarText: "All Topics"),
      ),
    );
  }
}
