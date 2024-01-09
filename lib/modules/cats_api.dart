// import 'dart:convert';

import 'dart:convert';

import 'package:http/http.dart' as http;

class CatFactsModel {
  String fact;
  int length;

  CatFactsModel({required this.fact, required this.length});

  factory CatFactsModel.fromJson(Map<String, dynamic> jsonData) {
    return switch (jsonData) {
      {'fact': String fact, 'length': int length} =>
        CatFactsModel(fact: fact, length: length),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

class CatsApi {
  static const _baseURL = 'https://catfact.ninja/';

  final http.Client _client;

  CatsApi() : _client = http.Client();

  Future<CatFactsModel> getCatsFact() async {
    var uri = Uri.parse('${_baseURL}fact');

    var response = await _client.get(uri);
    if (response.statusCode != 200) {
      throw Exception("Response's not okay");
    }

    String converted = const Utf8Decoder().convert(response.bodyBytes);
    dynamic decoded = json.decode(converted);

    return CatFactsModel.fromJson(decoded);
  }
}
