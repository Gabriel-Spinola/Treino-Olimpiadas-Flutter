import 'package:flutter/material.dart';
import 'package:pretty_app/views/home_view.dart';

class IntroView extends StatelessWidget {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // logo
          Padding(
            padding: const EdgeInsets.only(
              left: 80.0,
              right: 80.0,
              bottom: 60.0,
              top: 120.0,
            ),
            child: Image.asset('lib/assets/avocado.png'),
          ),

          // Title
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Super cool avocados",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const Text("I'm a subtitle"),

          const Spacer(),

          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 226, 130, 162),
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: const EdgeInsets.all(24.0),
              child: const Text(
                "Enter",
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeView(),
              ),
            ),
          ),

          const Spacer()
        ],
      ),
    );
  }
}
