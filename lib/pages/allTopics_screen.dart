import 'dart:convert';
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

      body: FutureBuilder<Map<String, dynamic>>(
        future: loadJson(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final topics = snapshot.data!; // Map<String, dynamic>

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: topics.length,
            itemBuilder: (context, index) {
              final String key = topics.keys.elementAt(index); // Day 1
              // String value = topics[key]; // day one data
              final Map<String, dynamic> jsonData =
                  topics[key] as Map<String, dynamic>;
              // return GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => TopicPage(value: value),
              //       ),
              //     );
              //   },
              //   child: Card(
              //     margin: const EdgeInsets.symmetric(vertical: 8),
              //     child: ListTile(
              //       title: Text(key), // shows Day 1
              //       subtitle: Text(value), // shows day one data
              //     ),
              //   ),
              // );

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
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

                    //
                    // Container(
                    //   margin: const EdgeInsets.all(15),
                    //   child: ElevatedButton(
                    //     onPressed: () async {
                    //       await Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => TopicPage(
                    //             topicData: jsonData,
                    //             topic: key,
                    //             heading: jsonData['heading'],
                    //           ),
                    //         ),
                    //       );
                    //       _loadSharedPreferencesData();
                    //     },
                    //     child: Text(
                    //       prefs.getBool('topic_$key') ?? false
                    //           ? "Readed"
                    //           : "View",
                    //     ),
                    //   ),
                    // ),
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
          );
        },
      ),
    );
  }
}
