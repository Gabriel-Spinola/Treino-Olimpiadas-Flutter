import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cu/modules/imodel.dart';

typedef QueryDocumentList = List<QueryDocumentSnapshot<Map<String, dynamic>>>;

/// Interface for basic CRUD operations
abstract class ICollection {
  Future<QueryDocumentList> get();
  DocumentReference<Map<String, dynamic>> getById(String id);
  Future<void> create(IModel data);
}