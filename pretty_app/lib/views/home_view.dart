import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pretty_app/components/avocado_item_tile.dart';
import 'package:pretty_app/views/intro_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return const AvocadoItemTile();
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
