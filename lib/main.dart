import 'package:cu/modules/cats_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Project designed to lean mobile dev for my fiemg training application
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
    var catsApi = CatsApi();

    catsApi.getCatsFact()
      .then((value) {
        if (kDebugMode) {
          print('${value!.fact}no fact\nlength: ${value.length}');
        }
      })
      .catchError((error) {
        if (kDebugMode) {
          print(error.toString());
        }

        return Future(() => null);
      });

    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
