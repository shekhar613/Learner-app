import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/pages/allTopics_screen.dart';
import 'package:my_app/pages/topics.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  final String text;

  const Body({super.key, required this.text});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late SharedPreferences prefs;
  int daysComplete = 0;
  double progressValue = 0.0;
  late Map<String, dynamic> jsonDataLength;

  @override
  void initState() {
    super.initState();

    _loadSharedPreferencesData();
  }

  Future<void> _loadSharedPreferencesData() async {
    prefs = await SharedPreferences.getInstance();
    daysComplete = prefs.getInt("flutterChallengeDaysCount") ?? 0;

    setState(() {});
    print("reloaded...................");
  }

  // Load JSON from assets/topics.json
  Future<Map<String, dynamic>> loadJson() async {
    String jsonString = await rootBundle.loadString('assets/topics.json');

    jsonDataLength = json.decode(jsonString) as Map<String, dynamic>;
    progressValue = daysComplete / jsonDataLength.length;
    return json.decode(jsonString)
        as Map<String, dynamic>; // Map<String, dynamic>
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: loadJson(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final topics = snapshot.data!; // Map<String, dynamic>

        return Container(
          width: double.infinity,
          height: 450,
          margin: EdgeInsets.all(12),
          child: Card(
            elevation: 5,
            color: Colors.amber,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Flutter 60 Days Challenge",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                  ),
                  LinearProgressIndicator(
                    value: progressValue,
                    minHeight: 10,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation(
                      const Color.fromARGB(255, 27, 145, 255),
                    ),
                  ),

                  Text(
                    " $daysComplete/${jsonDataLength.length}  (${(progressValue * 100).toInt()}%)",
                  ),

                  ElevatedButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AllTopicsScreen(navbarText: "navbarText"),
                        ),
                      );
                      _loadSharedPreferencesData();
                    },
                    child: Text("Start"),
                  ),
                  Row(
                    children: [
                      Card(
                        margin: EdgeInsets.all(10),
                        child: Text("Completed days : $daysComplete"),
                      ),
                      SizedBox(width: 10),
                      Card(
                        child: Text(
                          "Days left : ${jsonDataLength.length - daysComplete}",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
