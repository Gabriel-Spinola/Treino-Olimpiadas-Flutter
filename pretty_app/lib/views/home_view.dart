import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pretty_app/components/avocado_item_tile.dart';
import 'package:pretty_app/modules/avocados_module.dart';
import 'package:pretty_app/views/intro_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<List<AvocadoModel>> _avocados;

  @override
  void initState() {
    var apiService = AvocadoAPI();
    _avocados = apiService.getAvocados();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Makes the ui avoid the operating system areas
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 42.0),

              // Title section
              const Text("Good Morning"),

              const SizedBox(height: 4.0),

              // Title
              const Text(
                "Let's order some fresh avocados",
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
              ),

              const Divider(),
              const SizedBox(height: 24.0),

              // Store section
              const Text("Fresh Avocados"),

              // Grid
              Expanded(
                child: FutureBuilder<List<AvocadoModel>>(
                  future: _avocados,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }

                    if (snapshot.hasData && snapshot.data!.isEmpty) {
                      return const Text("No data found");
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      return GridView.builder(
                        itemCount: snapshot.data!.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          var model = snapshot.data![index];

                          return AvocadoItemTile(model: model);
                        },
                      );
                    }

                    return const CircularProgressIndicator();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
