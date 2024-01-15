import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cu/modules/ICollection.dart';
import 'package:cu/modules/imodel.dart';

class ShacoBoxField {
  static const name = 'name';
  static const property = 'property';
  static const amount = 'amount';
}

class ShacoBoxModel implements IModel {
  String? id;
  String name;
  String property;
  int amount;

  ShacoBoxModel({
    this.id,
    required this.name,
    required this.property,
    required this.amount,
  });

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'property': property,
      'amount': amount
    };
  }
}

class ShacoBoxesCollection implements ICollection {
  static const String collection = "Shaco Boxes";

  @override
  Future<QueryDocumentList> get() async {
    var querySnapshot =
        await FirebaseFirestore.instance.collection(collection).get();
    var documents = querySnapshot.docs;
    
    return documents;
  }

  @override
  DocumentReference<Map<String, dynamic>> getById(String id) {
    return FirebaseFirestore.instance.collection(collection).doc(id);
  }

  @override
  Future<String?> create(IModel data) async {
    var ref = await FirebaseFirestore.instance
        .collection(collection)
        .add(data.toMap());

    return ref.id;
  }

  Future<String?> delete(String id) async {
    await FirebaseFirestore.instance.collection(collection).doc(id).delete();

    return id;
  }

  Future<void> update(String id, IModel data) async {
    return FirebaseFirestore.instance.collection(collection).doc(id).update(data.toMap());
  }
}
