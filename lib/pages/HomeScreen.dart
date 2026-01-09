import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/pages/allTopics_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homescreen extends StatefulWidget {
  final String text;

  const Homescreen({super.key, required this.text});

  @override
  State<Homescreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<Homescreen> {
  // page states
  late SharedPreferences prefs;
  int daysComplete = 0;
  double progressValue = 0.0;
  Map<String, dynamic>? jsonDataLength;

  @override
  void initState() {
    super.initState();

    _init();
  }

  Future<void> _init() async {
    await _loadSharedPreferencesData();
    await loadJson();
  }

  // function to delete the shared preferences data
  Future<void> clearAllPrefs() async {
    await prefs.clear();
  }

  Future<void> _loadSharedPreferencesData() async {
    prefs = await SharedPreferences.getInstance();
    daysComplete = prefs.getInt("flutterChallengeDaysCount") ?? 0;

    setState(() {});
    print("reloaded...................");
  }

  // Load JSON from assets/topics.json
  Future<void> loadJson() async {
    final jsonString = await rootBundle.loadString('assets/topics.json');
    final data = json.decode(jsonString) as Map<String, dynamic>;

    setState(() {
      jsonDataLength = data;
      progressValue = daysComplete / data.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (jsonDataLength == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Section first header after the appBar
              Container(
                width: double.infinity,
                height: 120,
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

              Transform.translate(
                offset: Offset(0, -25),
                child: SizedBox(
                  width: 350,
                  height: 425,
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: BorderSide(color: Colors.white, width: 2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 120,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 238, 151, 0),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(18),
                                topRight: Radius.circular(18),
                              ),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            left: 5,
                                            right: 5,
                                            top: 2,
                                            bottom: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                              255,
                                              238,
                                              151,
                                              0,
                                            ).withOpacity(0.5),
                                          ),
                                          child: Text(
                                            "CURRENT FOCUS",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.code,
                                        color: const Color.fromARGB(
                                          255,
                                          255,
                                          220,
                                          115,
                                        ),
                                        size: 45,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Text(
                                      "Flutter 60 Days Challenge",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Progress",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: const Color.fromARGB(
                                          255,
                                          108,
                                          108,
                                          108,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "${(progressValue * 100).toInt()} %",
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                          255,
                                          204,
                                          129,
                                          0,
                                        ),
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                LinearProgressIndicator(
                                  value: progressValue,
                                  minHeight: 12,
                                  borderRadius: BorderRadius.circular(20),
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    234,
                                    234,
                                    234,
                                  ),
                                  valueColor: AlwaysStoppedAnimation(
                                    const Color.fromARGB(255, 204, 129, 0),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Day $daysComplete of ${jsonDataLength!.length}",
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                          255,
                                          108,
                                          108,
                                          108,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Keep going!",
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                          255,
                                          108,
                                          108,
                                          108,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 150,
                                      height: 125,
                                      child: Card(
                                        color: const Color.fromARGB(
                                          255,
                                          234,
                                          234,
                                          234,
                                        ),
                                        elevation: 0,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.check_circle_outline,
                                              size: 30,
                                              color: Colors.green,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "$daysComplete",
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "DAYS DONE",
                                              style: TextStyle(
                                                color: const Color.fromARGB(
                                                  255,
                                                  108,
                                                  108,
                                                  108,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    Container(
                                      width: 150,
                                      height: 125,
                                      child: Card(
                                        color: const Color.fromARGB(
                                          255,
                                          234,
                                          234,
                                          234,
                                        ),
                                        elevation: 0,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.hourglass_top,
                                              size: 30,
                                              color: const Color.fromARGB(
                                                255,
                                                42,
                                                106,
                                                255,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "${jsonDataLength!.length - daysComplete}",
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "DAYS LEFT",
                                              style: TextStyle(
                                                color: const Color.fromARGB(
                                                  255,
                                                  108,
                                                  108,
                                                  108,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                SizedBox(
                                  child: GestureDetector(
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AllTopicsScreen(
                                            navbarText: "60 Days of Flutter",
                                          ),
                                        ),
                                      );
                                      _init();
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                          255,
                                          238,
                                          151,
                                          0,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),

                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Continue Challenge",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(left: 25, right: 25),
                height: 400,
                // decoration: BoxDecoration(color: Colors.blue),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Daily Task",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                      ),
                    ),
                    Container(
                      height: 80,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 20),
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.lightGreenAccent.withOpacity(
                                    0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: const Color.fromARGB(255, 0, 180, 18),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Watch Video Tutorial",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text("Completed at 10:00 AM"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: 80,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 20),
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(
                                    255,
                                    90,
                                    187,
                                    252,
                                  ).withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Icon(
                                  Icons.code,
                                  color: const Color.fromARGB(255, 0, 120, 180),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Practice Coding",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text("Pending - 1 hour"),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 100),

                                child: Icon(
                                  Icons.play_arrow,
                                  color: const Color.fromARGB(255, 180, 87, 0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {
                        clearAllPrefs();
                        _init();
                      },
                      child: Container(
                        height: 80,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 20),
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                      255,
                                      125,
                                      125,
                                      125,
                                    ).withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Icon(
                                    Icons.lock,
                                    color: const Color.fromARGB(
                                      255,
                                      116,
                                      116,
                                      116,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Quiz: State Management",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text("Unloack after practice"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
