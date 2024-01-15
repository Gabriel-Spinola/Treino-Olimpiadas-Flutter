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
  final _formKey = GlobalKey<FormState>();
  final _propertyField = TextEditingController();
  final _shacoBoxNameField = TextEditingController();

  late ShacoBoxesCollection _shacoCollection;
  late Future<QueryDocumentList> _shacoBoxes;

  Future<void> addShacoBox(ShacoBoxModel data) async {
    try {
      String? id = await _shacoCollection.create(data);

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
    _shacoCollection = ShacoBoxesCollection();
    _shacoBoxes = _shacoCollection.get();

    super.initState();
  }

  @override
  void dispose() {
    _propertyField.dispose();
    _shacoBoxNameField.dispose();

    super.dispose();
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
      floatingActionButton: openFormAlertButton(const Icon(Icons.add)),
      bottomNavigationBar: const NavBar(),
    );
  }

  Widget dataColumn(final QueryDocumentList documents) {
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
              openFormAlertButton(const Icon(Icons.edit)),
            ],
          ),
          onDismissed: (direction) {
            removeShacoBox(document.id);

            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('dismissed')));
          },
        );
      },
    );
  }

  Widget openFormAlertButton(final Icon icon) {
    return FloatingActionButton(
      child: icon,
      onPressed: () {
        showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
            content: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  right: -40,
                  top: -40,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Icon(Icons.close),
                    ),
                  ),
                ),
                shacoBoxForm(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget shacoBoxForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          textFormField(
            'New shaco box name',
            'Please enter a name',
            _shacoBoxNameField,
          ),
          textFormField(
            'New shaco box property',
            'Please enter a property',
            _propertyField,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
              child: const Text('Submit'),
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  // TODO - Handle error case
                  return;
                }

                var data = ShacoBoxModel(
                  name: _shacoBoxNameField.text,
                  property: _propertyField.text,
                  amount: 1,
                );

                addShacoBox(data).then((value) =>
                  Navigator.of(context).pop()
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget textFormField(
    final String hintText,
    final String emptyInputMessage,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(hintText: hintText),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return emptyInputMessage;
          }

          return null;
        },
      ),
    );
  }
}
