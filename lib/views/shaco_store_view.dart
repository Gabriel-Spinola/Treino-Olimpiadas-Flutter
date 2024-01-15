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

  late List<TextEditingController> _formFields;

  late ShacoBoxesCollection _shacoCollection;
  late Future<QueryDocumentList> _shacoBoxes;

  Future<void> _addShacoBox(ShacoBoxModel data) async {
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

  Future<void> _updateShacoBox(String id, ShacoBoxModel data) async {
    try {
      await _shacoCollection.update(id, data);

      if (kDebugMode) {
        print("New shaco box ID: $id");
      }
    } catch (error) {
      if (kDebugMode) {
        print("Failed to create ShacoBoxModel");
      }
    }
  }

  Future<String?> _removeShacoBox(String id) async {
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

  void _resetFormField() {
    for (var field in _formFields) {
      field.clear();
    }
  }

  @override
  void initState() {
    _shacoCollection = ShacoBoxesCollection();
    _shacoBoxes = _shacoCollection.get();

    _formFields = [_propertyField, _shacoBoxNameField];

    super.initState();
  }

  @override
  void dispose() {
    for (var field in _formFields) {
      field.dispose();
    }

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
                  return _dataColumn(snapshot.data!);
                }

                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: _openFormAlertButton(const Icon(Icons.add)),
      bottomNavigationBar: const NavBar(),
    );
  }

  Widget _dataColumn(final QueryDocumentList documents) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: documents.length,
      itemBuilder: (context, index) {
        final document = documents[index];
        var data = ShacoBoxModel(
            id: document.id,
            name: document.get(ShacoBoxField.name),
            property: document.get(ShacoBoxField.property),
            amount: document.get(ShacoBoxField.amount));

        return Dismissible(
          key: Key(document.id),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(data.name),
              Text(data.amount.toString()),
              Text(data.property),
              _openFormAlertButton(const Icon(Icons.edit), initialData: data),
            ],
          ),
          onDismissed: (direction) {
            _removeShacoBox(document.id);

            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('dismissed')));
          },
        );
      },
    );
  }

  Widget _openFormAlertButton(final Icon icon, {ShacoBoxModel? initialData}) {
    return FloatingActionButton(
      child: icon,
      onPressed: () {
        // NOTE - Prevents data from the 'edit' action to overwrite hintText on the 'create' action
        _resetFormField();

        if (initialData != null) {
          _shacoBoxNameField.text = initialData.name;
          _propertyField.text = initialData.property;
        }

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
                    onTap: () => Navigator.of(context).pop(),
                    child: const CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Icon(Icons.close),
                    ),
                  ),
                ),
                _shacoBoxForm(initialData?.id),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _shacoBoxForm(String? id) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _textFormField(
            'New shaco box name',
            'Please enter a name',
            _shacoBoxNameField,
          ),
          _textFormField(
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

                if (id == null) {
                  _addShacoBox(data).then((value) {
                    _resetFormField();

                    Navigator.of(context).pop();
                  });

                  return;
                }

                _updateShacoBox(id, data).then((value) {
                  _resetFormField();

                  Navigator.of(context).pop();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _textFormField(
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
