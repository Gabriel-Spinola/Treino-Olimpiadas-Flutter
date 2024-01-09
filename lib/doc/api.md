# HTTP - Guide
https://docs.flutter.dev/data-and-backend/networking

## Setup
### Deps
```yaml
depedencies:
  http: ^1.1.2
```

### Perms
`android/app/src/main/AndroidManifest.xml`
```xml
<!-- Required to fetch data from the internet. -->
<uses-permission android:name="android.permission.INTERNET" />
```

## Consuming
Consuming comes into two parts:
 1. Modeling
 2. Consuming

### Example of GET req
1. Modeling
```dart
class Model {
  String field1;
  String field2;
  int field3;

  Model({required this.field1, required this.field2, ...});

  // Model factory for constructing the model from a json Map 
  factory Model.fromJson(Map<String, dynamic> jsonData) {
    return switch (jsonData) {
      {'field1': String field1, ..., 'field3': int field3} =>
        Model(field1: field1, ..., field3: field3),
      _ => throw const FormatException('Failed to load model.'),
    };
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
  Future<Model?> getData() async {
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

3. Displaying the data
```dart
late Future<CatFactsModel> _data;

@override
void initState() {
  super.initState();

  var apiService = API();
  _data = apiService.getData();
}

FutureBuilder<Model>(
  future: _future,
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return dataColumn(snapshot.data!);
    }

    if (snapshot.hasError) {
      return Text('${snapshot.error}');
    }

    return const CircularProgressIndicator();
  },
),
```
