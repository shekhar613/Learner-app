import 'package:flutter/material.dart';

class Taichigetstartscreen extends StatefulWidget {
  const Taichigetstartscreen({super.key});

  @override
  State<Taichigetstartscreen> createState() => _TaichigetstartscreenState();
}

class _TaichigetstartscreenState extends State<Taichigetstartscreen> {
  final Color primaryGreen = const Color(0xFF4F6F52);
  final Color background = const Color(0xFFF6F7F2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              /// ⭐ Rating
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) =>
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                ),
              ),

              const SizedBox(height: 10),

              /// Trusted text
              Text(
                "TRUSTED BY OVER 100,000 PRACTITIONERS",
                style: TextStyle(
                  fontSize: 12,
                  letterSpacing: 1.2,
                  color: primaryGreen.withOpacity(0.7),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              /// Title
              Text(
                "Master Your Flow:",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              Text(
                "Tai Chi for\nEveryone",
                style: TextStyle(
                  fontSize: 34,
                  height: 1.2,
                  fontWeight: FontWeight.w700,
                  color: primaryGreen,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              /// Image Card
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset(
                      "assets/images/taichiIndoore.jpg",
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  /// Floating Badge
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                              color: primaryGreen.withOpacity(0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.spa, color: primaryGreen),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "DAILY ZEN",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "New Guided Sessions",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// Description
              Text(
                "Embark on a journey of mindfulness, balance, and inner peace with our expert-led programs.",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade700,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              /// CTA Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Begin Your Journey",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// Login text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Log in",
                      style: TextStyle(
                        color: primaryGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
