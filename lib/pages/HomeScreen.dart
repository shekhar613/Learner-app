import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Homescreen extends StatefulWidget {
  final String text;

  const Homescreen({super.key, required this.text});

  @override
  State<Homescreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<Homescreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Section first header after the appBar
        Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 238, 151, 0),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          child: Container(
            margin: EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  "Welcome back,",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  "Ready to crush it?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
