import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/components/appbar.dart';

class TopicPage extends StatefulWidget {
  final String topic;
  final String heading;
  final Map<String, dynamic> topicData;

  const TopicPage({
    super.key,
    required this.topicData,
    required this.topic,
    required this.heading,
  });

  @override
  State<TopicPage> createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  bool isRead = false;

  @override
  void initState() {
    super.initState();
    _checkIfRead();
  }

  /// Check if topic already marked as read
  Future<void> _checkIfRead() async {
    final prefs = await SharedPreferences.getInstance();
    bool saved = prefs.getBool('topic_${widget.topic}') ?? false;

    setState(() {
      isRead = saved;
    });
  }

  /// Mark topic as done
  Future<void> _markAsDone() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('topic_${widget.topic}', true);
    bool exists = prefs.containsKey('flutterChallengeDaysCount');
    if (exists) {
      int? dayscompleted = prefs.getInt("flutterChallengeDaysCount") ?? 0;
      await prefs.setInt("flutterChallengeDaysCount", dayscompleted + 1);
    } else {
      await prefs.setInt("flutterChallengeDaysCount", 1);
    }

    setState(() {
      isRead = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> subTopics =
        widget.topicData['subTopics'] as Map<String, dynamic>;

    return Scaffold(
      appBar: SimpleAppBar(title: widget.heading),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Topic Content
            Expanded(
              flex: 9,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        widget.topicData['details'],
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontSize: 16),
                      ),
                      subTopicsSection(subTopics),
                    ],
                  ),
                ),
              ),
            ),

            // Button
            AnimatedContainer(
              width: double.infinity,
              margin: const EdgeInsets.all(15),
              duration: const Duration(milliseconds: 20000),
              // curve: Curves.easeInOut,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isRead
                      ? Colors.amberAccent
                      : const Color.fromARGB(255, 115, 192, 255),
                ),
                onPressed: isRead ? null : _markAsDone,

                child: Text(isRead ? "Completed" : "View"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView subTopicsSection(Map<String, dynamic> subTopics) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: subTopics.length,
      itemBuilder: (context, index) {
        final key = subTopics.keys.elementAt(index);
        final value = subTopics[key] as Map<String, dynamic>;

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  key,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(value['details']),
                const SizedBox(height: 8),
                Text(
                  value['example'],
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
