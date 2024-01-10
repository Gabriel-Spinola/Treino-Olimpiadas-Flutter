import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cu/modules/imodel.dart';

/// Interface for basic CRUD operations
abstract class ICollection {
  Future<QuerySnapshot<Map<String, dynamic>>> get();
  DocumentReference<Map<String, dynamic>> getById(String id);
  Future<void> create(IModel data);
}