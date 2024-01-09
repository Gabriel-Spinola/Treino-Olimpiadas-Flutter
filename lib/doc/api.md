# HTTP - Guide

## Deps
```yaml
depedencies:
  http: ^1.1.2
```

## Consuming
Consuming comes into two parts:
 1. Modeling
 2. Consuming

### Example of GET req
1. Modeling
```dart
class Model {
  String? field1;
  String? field2;
  int? field3;

  Model({this.fact, this.length});

  // Model factory for constructing the model from a json Map 
  factory Model.fromJson(Map<String, dynamic> jsonData) {
    return Model(
      fact: jsonData['fact'],
      length: jsonData['length'],
      length: jsonData['length'],
    );
  }
}
``` 

2. Consuming
```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class API {
  static const _baseURL = 'https://urlfoda/';

  // NOTE - This can also be wrapped by a try and on/catch block 
  Future<Model?> get() async {
    var client = http.Client();
    var uri = Uri.parse('${_baseURL}route');

    var response = await client.get(uri);
    if (response.statusCode != 200) {
      throw ErrorDescription("Response's not okay");
    }

    // Parse to utf8 string
    String converted = const Utf8Decoder().convert(response.bodyBytes);

    // Decode to json
    dynamic decoded = json.decode(converted);

    return Model.fromJson(decoded);
  }
}
```