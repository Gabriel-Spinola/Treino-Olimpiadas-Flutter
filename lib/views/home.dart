import 'package:cu/widgets/nav_bar.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text("Hello, World!"),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}
