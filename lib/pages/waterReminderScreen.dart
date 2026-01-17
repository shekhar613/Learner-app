import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class Waterreminderscreen extends StatefulWidget {
  @override
  State<Waterreminderscreen> createState() => WaterreminderscreenState();
}

class WaterreminderscreenState extends State<Waterreminderscreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: _inpageAppBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 1,
            colors: [Colors.teal.shade50, Colors.white],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // progress
                _showProgress(context),

                // cards
                Container(
                  // color: Colors.amber,
                  // color: const Color.fromARGB(255, 83, 46, 46),
                  // margin: EdgeInsets.only(top: 1, right: 1, left: 2),
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.33,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Expanded(
                              flex: 1,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 450),
                                child: _hydrationCard(),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: SizedBox(
                                height: height * 0.35,
                                child: Container(
                                  // color: Colors.amber,
                                  child: Column(
                                    children: [
                                      Expanded(child: _stepsCard()),
                                      Expanded(child: _exerciseCard()),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      _caloriBurnStaus(),

                      // Continue section
                      _continueSection(height),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _continueSection(height) {
    return Container(
      margin: EdgeInsets.all(8),
      // height = 180
      height: height * 0.22,
      // padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/wall.webp"),
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
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.white, Colors.white30],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'CONTINUE SESSION',
                style: TextStyle(
                  fontSize: 12,
                  letterSpacing: 1.2,
                  color: Color(0xFF2FA4A9),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),

              const Text(
                'Wall Pilates',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const Text(
                'Core Strength',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 5),

              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2FA4A9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Resume',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'timer 12m left',
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _caloriBurnStaus() {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 15.0,
              left: 20,
              right: 20,
              bottom: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Burn",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "750",
                          style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 34,
                          ),
                        ),
                        SizedBox(width: 2),
                        Text(
                          "kcal",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 5, end: 70),
                  duration: const Duration(seconds: 1),
                  builder: (context, value, child) {
                    return Container(
                      // color: Colors.amber,
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            height: value <= 20 ? value : 20, //20
                            width: 20,

                            decoration: BoxDecoration(
                              color: Colors.teal.shade50,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          Container(
                            height: value <= 45 ? value : 45, //45
                            width: 20,
                            decoration: BoxDecoration(
                              color: Colors.teal.shade100,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          Container(
                            height: value <= 30 ? value : 30, //30
                            width: 20,
                            decoration: BoxDecoration(
                              color: Colors.teal.shade200,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          Container(
                            height: value <= 60 ? value : 60, //60
                            width: 20,
                            decoration: BoxDecoration(
                              color: Colors.teal.shade300,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _exerciseCard() {
    return Container(
      // height: 120,
      // width: 170,
      // margin: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "exercise",
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                "Excercise",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              Text(
                "45 min",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _stepsCard() {
    return Container(
      // height: 120,
      // width: 170,
      // margin: EdgeInsets.only(left: 10, bottom: 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "bolt",
                    style: TextStyle(
                      color: Colors.amberAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                        255,
                        255,
                        231,
                        73,
                      ).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 1, left: 5, right: 5),
                      child: Text(
                        "TOP 5%",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.orange,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                "Steps",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              Text(
                "8,052",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _hydrationCard() {
    return Container(
      // color: Colors.transparent,
      // margin: EdgeInsets.only(left: 5),
      width: 170,
      // height: 235,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 10, end: 150),
        duration: const Duration(seconds: 1),
        builder: (context, value, child) {
          return Card(
            color: Colors.white,
            child: Stack(
              children: [
                // Content
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "HYDRATION",
                        style: TextStyle(
                          fontSize: 11,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text(
                            "1.2",
                            style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            "/2L",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Wave SVG
                Positioned(
                  bottom: -1,
                  left: 0,
                  right: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SvgPicture.asset(
                      'assets/images/SVG/wave1.svg',
                      width: double.infinity,
                      height: value + 40,
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.teal.withOpacity(0.5),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -1,
                  left: 0,
                  right: 0,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(3.1416),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SvgPicture.asset(
                        'assets/images/SVG/wave2.svg',
                        width: double.infinity,
                        height: value,
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.teal.withOpacity(0.3),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),

                // Add button
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
                      child: Text(
                        "add",
                        style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Container _showProgress(BuildContext context) {
    return Container(
      child: SizedBox(
        height: MediaQuery.of(context).size.width * 0.7,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Progress ring
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.55,
              height: MediaQuery.of(context).size.width * 0.55,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 0.7),
                  duration: const Duration(seconds: 1),
                  builder: (context, value, child) {
                    return CircularProgressIndicator(
                      strokeWidth: 15,
                      value: value,
                      backgroundColor: Colors.teal.withOpacity(0.2),
                      valueColor: const AlwaysStoppedAnimation(Colors.teal),
                      strokeCap: StrokeCap.round,
                    );
                  },
                ),
              ),
            ),

            // Center text
            Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  "75%",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: Colors.teal,
                  ),
                ),
                Text(
                  "DAILY GOAL",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  AppBar _inpageAppBar() {
    return AppBar(
      backgroundColor: Colors.white,

      // surfaceTintColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.bottomCenter,
            radius: 4,
            colors: [Colors.teal.shade50, Colors.white],
          ),
        ),
      ),
      title: Text(
        "Your Progress",
        style: TextStyle(fontWeight: FontWeight.w900),
      ),
      centerTitle: true,
      actions: [
        Container(
          height: 50,
          width: 50,
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.bottomCenter,
              radius: 4,
              colors: [Colors.teal.shade50, Colors.white],
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.notifications, size: 26),
          ),
        ),
      ],
    );
  }
}
