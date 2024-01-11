import 'package:cu/modules/icollection.dart';
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
  late Future<QueryDocumentList> _shacoBoxes;

  Future<void> addShacoBox() async {
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
  }

  Future<String?> removeShacoBox(String id) async {
    try {
      _shacoCollection.delete(id);

      if (kDebugMode) {
        print("deleted shaco box ID: $id");
      }

      return id;
    } catch (error) {
      if (kDebugMode) {
        print("Failed to delete shacobox");
      }

      return null;
    }
  }

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
            FutureBuilder<QueryDocumentList>(
              future: _shacoBoxes,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                if (snapshot.hasData && snapshot.data!.isEmpty) {
                  return const Text("Document does not exist");
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  return dataColumn(snapshot.data!);
                }

                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addShacoBox,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }

  Widget dataColumn(QueryDocumentList documents) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: documents.length,
      itemBuilder: (context, index) {
        final document = documents[index];

        return Dismissible(
          key: Key(document.id),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(document.get(ShacoBoxField.name)),
              Text(document.get(ShacoBoxField.amount).toString()),
              Text(document.get(ShacoBoxField.property)),
            ],
          ),
          onDismissed: (direction) async {
            removeShacoBox(document.id);

            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('dismissed')));
          },
        );
      },
    );
  }
}
