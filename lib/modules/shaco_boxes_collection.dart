import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cu/modules/ICollection.dart';
import 'package:cu/modules/imodel.dart';
import 'package:flutter/foundation.dart';

class ShacoBoxModel implements IModel {
  String name;
  String property;
  int amount;

  ShacoBoxModel({
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
  Future<QuerySnapshot<Map<String, dynamic>>> get() {
    return FirebaseFirestore.instance.collection(collection).get();
  }

  @override
  DocumentReference<Map<String, dynamic>> getById(String id) {
    return FirebaseFirestore.instance.collection(collection).doc(id);
  }

  @override
  Future<String?> create(IModel data) async {
    try {
      var ref = await FirebaseFirestore.instance
          .collection(collection)
          .add(data.toMap());

      return ref.id;
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }

      return null;
    }
  }
}
