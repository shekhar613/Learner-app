import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/components/appbar.dart';
import 'package:my_app/pages/topics.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllTopicsScreen extends StatefulWidget {
  final String navbarText;

  const AllTopicsScreen({super.key, required this.navbarText});

  @override
  State<AllTopicsScreen> createState() => _AllTopicsScreenState();
}

class _AllTopicsScreenState extends State<AllTopicsScreen> {
  late SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    _loadSharedPreferencesData();
  }

  Future<void> _loadSharedPreferencesData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {});
    print("reloaded...................");
  }

  // Load JSON from assets/topics.json
  Future<Map<String, dynamic>> loadJson() async {
    String jsonString = await rootBundle.loadString('assets/topics.json');
    print(json.decode(jsonString) as Map<String, dynamic>);
    return json.decode(jsonString)
        as Map<String, dynamic>; // Map<String, dynamic>
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: widget.navbarText),

      body: Container(
        color: const Color.fromARGB(255, 244, 244, 244),
        child: FutureBuilder<Map<String, dynamic>>(
          future: loadJson(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final topics = snapshot.data!; // Map<String, dynamic>

            return SafeArea(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: topics.length + 1, //+1 for header section
                itemBuilder: (context, index) {
                  //Header
                  if (index == 0) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 120,
                          child: Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 22,
                                left: 22,
                                right: 22,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "OVERALL PROGRESS",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        "12%",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: Colors.amber,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  LinearProgressIndicator(
                                    value: 0.5,
                                    minHeight: 10,
                                    borderRadius: BorderRadius.circular(50),
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
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "7 of 60 days completed",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                          ),
                                          Transform.translate(
                                            offset: Offset(-5, 0),
                                            child: Container(
                                              height: 25,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                color: Colors.amberAccent,
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              child: Text(
                                                "+12",
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  final topicIndex = index - 1;
                  final String key = topics.keys.elementAt(topicIndex); // Day 1
                  // String value = topics[key]; // day one data
                  final Map<String, dynamic> jsonData =
                      topics[key] as Map<String, dynamic>;

                  // return completed days
                  if (prefs.getBool('topic_$key') ?? false) {
                    return GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TopicPage(
                              topicData: jsonData,
                              topic: key,
                              heading: jsonData['heading'],
                            ),
                          ),
                        );
                        _loadSharedPreferencesData();
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 5,
                              left: 15,
                              bottom: 5,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,

                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          key,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "•",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          " COMPLETED",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            color: const Color.fromARGB(
                                              255,
                                              57,
                                              188,
                                              0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    SizedBox(
                                      width: 255,
                                      child: Text(
                                        jsonData['heading'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.all(20),
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.lightGreenAccent.withOpacity(
                                      0.6,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.check_circle,
                                    color: const Color.fromARGB(255, 0, 144, 5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  //  else {
                  //   return Text("not completed");
                  // }

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 1.0,
                        color: const Color.fromARGB(255, 255, 235, 86),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Container(
                              child: Text(
                                key,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            subtitle: Text(
                              // '${jsonData['details'].toString().substring(8)}...',
                              jsonData['heading'],
                            ),
                          ),
                        ),

                        AnimatedContainer(
                          margin: const EdgeInsets.all(15),
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  (prefs.getBool('topic_$key') ?? false)
                                  ? Colors.amberAccent
                                  : const Color.fromARGB(255, 115, 192, 255),
                            ),
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TopicPage(
                                    topicData: jsonData,
                                    topic: key,
                                    heading: jsonData['heading'],
                                  ),
                                ),
                              );
                              _loadSharedPreferencesData();
                            },
                            child: Text(
                              prefs.getBool('topic_$key') ?? false
                                  ? "Completed"
                                  : "View",
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
