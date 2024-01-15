use default setup documentation
`flutterfire config`

## Firestore Documentation
https://firebase.flutter.dev/docs/firestore/usage/

## Realtime changes
https://firebase.flutter.dev/docs/firestore/usage/#realtime-changes

## Collection structure
### Interfaces
```dart
abstract class IModel {
  Map<String, dynamic> toMap();
}

typedef QueryDocumentList = List<QueryDocumentSnapshot<Map<String, dynamic>>>;

abstract class ICollection {
  Future<QueryDocumentList> get();
  DocumentReference<Map<String, dynamic>> getById(String id);
  Future<void> create(IModel data);
}
```

### Collection concrete implementation
```dart
/// Document fields class
class Fields {
  static const field1 = 'field1';
  static const field2 = 'field2';
  ...
}

/// Document model class
class Model implements IModel {
  String fiel1;
  double field2;

  Model({required this.field1, required this.field2})

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'field1': field1,
      'field2': field2,
    };
  }
}

class Collection implements ICollection {
  static const collection = 'CollectionName';

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
  
  ...
}
```

## Typing
https://firebase.flutter.dev/docs/firestore/usage/#typing-collectionreference-and-documentreference