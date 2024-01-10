import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cu/modules/shaco_boxes_collection.dart';
import 'package:cu/widgets/nav_bar.dart';
import 'package:flutter/foundation.dart';
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
      body: Center(
        child: Column(
          children: [
            const Text("Shaco Store"),
            FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
              future: _shacoBoxes,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return dataColumn(snapshot.data!);
                }

                if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                return const CircularProgressIndicator();
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            String? id = await _shacoCollection.create(ShacoBoxModel(
              name: "test 1",
              property: 'property',
              amount: 2,
            ));

            if (kDebugMode) {
              print("New shaco box ID: $id");
            }
          } catch (error) {
            if (kDebugMode) {
              print("Failed to create ShacoBoxModel");
            }
          }
        },
      ),
      bottomNavigationBar: const NavBar(),
    );
  }

  Widget dataColumn(QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    return Column(
      children: [Text(querySnapshot.docs[0].get('name'))],
    );
  }
}
