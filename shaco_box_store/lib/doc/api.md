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

<application>
...
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

in order to se providers you have to add it to the pubspec

in order to conver json data to other data type than string

convert it to string first then the correct data type
i.e. `double.parse(jsonData['price'].toString())`

in order to retrieve multople data
loop the decoded data

pseudocode for http requests
HTTPResponse res = http.method(uri.parse(url))
if res != 200
  throw error

dyn decoded = jsonDecode(res.body)
model = Model.fromJson(decoded)

// if list
list items = empty(growable)

for Map<str, dyn> data in decoded['data location']
  items.add(Model.fromJson(data))