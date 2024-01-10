import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cu/modules/imodel.dart';
import 'package:cu/modules/shaco_boxes_collection.dart';
import 'package:cu/widgets/nav_bar.dart';
import 'package:flutter/material.dart';

class ShacoStoreView extends StatefulWidget {
  const ShacoStoreView({super.key});

  @override
  State<ShacoStoreView> createState() => _ShacoStoreViewState();
}

class _ShacoStoreViewState extends State<ShacoStoreView> {
  late ShacoBoxesCollection _shacoCollection;
  late Future<QuerySnapshot<Map<String, dynamic>>> _shacoBoxes;

  @override
  void initState() {
    super.initState();

    _shacoCollection = ShacoBoxesCollection();
    _shacoBoxes = _shacoCollection.get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: const Column(children: [Text("Shaco Store")]),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _shacoCollection.create(ShacoBoxModel(
            name: "test 1",
            property: 'property',
            amount: 2,
          ));
        },
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
