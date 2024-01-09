import 'package:cu/modules/cats_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// TODO - INIT GIT REPO

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
