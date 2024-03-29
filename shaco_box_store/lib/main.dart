import 'package:cu/firebase_options.dart';
import 'package:cu/routes/routes.dart';
import 'package:cu/views/cats_view.dart';
import 'package:cu/views/home.dart';
import 'package:cu/views/persistent_counter_view.dart';
import 'package:cu/views/shaco_store_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

/// Project designed to learn mobile dev for my fiemg training assesment
/// (obs: Focus on http)
///
/// TODO:
/// 
/// HTTP:
/// [X] - api integration
/// [ ] - API integrated APP
/// 
/// Flutter
/// [X] - Emulation
/// [X] - Routing
/// [X] - Basics of UI building
/// [ ] - Building and porting 
/// [ ] - Persistent local data
/// 
/// Firebase
/// [X] - Simple CRUD APP
///   [X] - Create
///   [X] - Read
///   [X] - Update
///   [X] - Delete
/// [ ] - Add realtime capabilities
/// 
/// 
/// JWT
/// [ ] - Auth

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
        AppRoutes.counter: (_) => const PersistentCounterView(),
        AppRoutes.shacoStore: (_) => const ShacoStoreView(),
      },
    );
  }
}
