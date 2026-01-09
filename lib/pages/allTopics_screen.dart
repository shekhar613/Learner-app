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
  int daysComplete = 0;

  @override
  void initState() {
    super.initState();
    _loadSharedPreferencesData();
  }

  Future<void> _loadSharedPreferencesData() async {
    prefs = await SharedPreferences.getInstance();
    daysComplete = prefs.getInt("flutterChallengeDaysCount") ?? 0;
    setState(() {});
  }

  Future<Map<String, dynamic>> loadJson() async {
    final jsonString = await rootBundle.loadString('assets/topics.json');
    return json.decode(jsonString) as Map<String, dynamic>;
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

            final topics = snapshot.data!;
            final keys = topics.keys.toList();

            /// find first incomplete topic ONCE
            final int firstIncompleteIndex = keys.indexWhere(
              (k) => !(prefs.getBool('topic_$k') ?? false),
            );

            return SafeArea(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: keys.length + 1,
                itemBuilder: (context, index) {
                  // ---------------- HEADER ----------------
                  if (index == 0) {
                    return showProgress(keys.length);
                  }

                  // ---------------- DATA ----------------
                  final topicIndex = index - 1;
                  final String key = keys[topicIndex];
                  final Map<String, dynamic> jsonData =
                      topics[key] as Map<String, dynamic>;

                  final bool isCompleted = prefs.getBool('topic_$key') ?? false;
                  final bool isActive = topicIndex == firstIncompleteIndex;

                  // ---------------- COMPLETED ----------------
                  if (isCompleted) {
                    return daysCompletedCards(key, jsonData);
                  }

                  // ---------------- ACTIVE ----------------
                  if (isActive) {
                    return activeContinueCard(
                      jsonData,
                      topicIndex,
                      context,
                      key,
                    );
                  }

                  // ---------------- NORMAL ----------------
                  return remainingDaysCard(key, jsonData, context);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Container remainingDaysCard(
    String key,
    Map<String, dynamic> jsonData,
    BuildContext context,
  ) {
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
              title: Text(
                key,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey,
                ),
              ),
              subtitle: Text(
                jsonData['heading'],
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Icon(Icons.lock, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Container activeContinueCard(
    Map<String, dynamic> jsonData,
    int topicIndex,
    BuildContext context,
    String key,
  ) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Card(
        color: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Colors.amber, width: 3),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 5, left: 15, bottom: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        key,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.amber,
                        ),
                      ),
                      SizedBox(width: 10),

                      Text(
                        "•  ACTIVE",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: 200,
                    child: Text(
                      jsonData['heading'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 21,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text("Complete the Day ${topicIndex + 1}"),
                  SizedBox(height: 5),
                ],
              ),
              GestureDetector(
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
                  width: 120,
                  margin: const EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Center(
                      child: Text(
                        "CONTINUE",
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container daysCompletedCards(String key, Map<String, dynamic> jsonData) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: GestureDetector(
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 5, left: 15, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          key,
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          "• COMPLETED",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Color.fromARGB(255, 57, 188, 0),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: 255,
                      child: Text(
                        jsonData['heading'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.lightGreenAccent.withOpacity(0.6),
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: Color.fromARGB(255, 0, 144, 5),
                  ),
                ),
              ],
            ),
          ),
        ),
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
      ),
    );
  }

  Column showProgress(int totalDays) {
    return Column(
      children: [
        SizedBox(
          height: 120,
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(top: 22, left: 22, right: 22),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "OVERALL PROGRESS",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "${((daysComplete / totalDays) * 100).toInt()}%",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: daysComplete / totalDays,
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(50),
                    backgroundColor: const Color.fromARGB(255, 234, 234, 234),
                    valueColor: AlwaysStoppedAnimation(
                      const Color.fromARGB(255, 204, 129, 0),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "$daysComplete of $totalDays days completed",
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
                              borderRadius: BorderRadius.circular(100),
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
                                borderRadius: BorderRadius.circular(100),
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
}
