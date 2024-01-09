import 'package:cu/routes/routes.dart';
import 'package:cu/views/cats_view.dart';
import 'package:cu/views/home.dart';
import 'package:flutter/material.dart';

/// Project designed to learn mobile dev for my fiemg training assesment
///
/// TODO:
/// [ ] - Simple CRUD APP with api integratiom
/// [ ] - Unit + Integration testing
/// [ ] - Basics of UI building
/// [ ] - Routing
/// [ ] - Building and porting

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Training",
      theme: ThemeData(primaryColor: Colors.white),
      routes: {
        AppRoutes.home: (_) => const HomeView(),
        AppRoutes.cats: (_) => const CatsView(),
      },
    );
  }
}
