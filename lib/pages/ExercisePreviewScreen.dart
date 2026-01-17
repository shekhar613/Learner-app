import 'package:flutter/material.dart';

class Exercisepreviewscreen extends StatefulWidget {
  @override
  State<Exercisepreviewscreen> createState() => ExercisepreviewscreenState();
}

class ExercisepreviewscreenState extends State<Exercisepreviewscreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    List<String> instructions = [
      'Stand tall with arms relaxed at your sides and your feet shoulder-width apart.',
      "Inhale deeply, raising both shoulders gently toward your ears.",
      "Exhale slowly, rolling shoulders forward and down in a smooth, circular motion. Repeat 5-8 times.",
      "After finishing forward rolls, switch direction and roll shoulders backward 5-8 times, keeping movements fluid and relaxed.",
    ];

    return Scaffold(
      appBar: _appBar(),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),

        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _imageSection(height),
                SizedBox(height: 15),

                // exercise details
                _exerciseDetails(),
                SizedBox(height: 15),

                // instructions section
                _instructionSection(instructions),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _instructionSection(List<String> instructions) {
    return Container(
      margin: EdgeInsets.only(left: 18, right: 15),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.list_alt,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade300,
                size: 30,
              ),
              SizedBox(width: 5),
              Text(
                "Instructions",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),

          Container(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: instructions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.teal.shade50.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.teal,
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    instructions[index],
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Container _exerciseDetails() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          Text(
            "Shoulder Rolls",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(height: 7),
          // details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          "Duration",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "00:59",
                          style: TextStyle(
                            color: Colors.teal,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          "Reps",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "15",
                          style: TextStyle(
                            color: Colors.teal,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(width: 10),
              Expanded(
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          "Exercise",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "1/6",
                          style: TextStyle(
                            color: Colors.teal,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _imageSection(double height) {
    return Container(
      height: height * 0.40,
      // color: Colors.amber,
      width: double.infinity,
      margin: EdgeInsets.all(10),

      child: Container(
        margin: EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/exercisepreview.png"),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],

          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 25,
              right: 24,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                    size: 36,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.white,

      title: Text(
        "Exercise Preview",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: [
        Container(
          margin: EdgeInsets.all(10),
          child: Icon(Icons.close, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
