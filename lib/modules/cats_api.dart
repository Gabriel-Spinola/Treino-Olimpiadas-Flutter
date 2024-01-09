// import 'dart:convert';

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CatFactsModel {
  String? fact;
  int? length;

  CatFactsModel({this.fact, this.length});

  factory CatFactsModel.fromJson(Map<String, dynamic> jsonData) {
    return CatFactsModel(
      fact: jsonData['fact'],
      length: jsonData['length'],
    );
  }
}

class CatsApi {
  static const _baseURL = 'https://catfact.ninja/';

  Future<CatFactsModel?> getCatsFact() async {
    var client = http.Client();
    var uri = Uri.parse('${_baseURL}fact');

    var response = await client.get(uri);
    if (response.statusCode != 200) {
      throw ErrorDescription("Response's not okay");
    }

    String converted = const Utf8Decoder().convert(response.bodyBytes);
    dynamic decoded = json.decode(converted);

    return CatFactsModel.fromJson(decoded);
  }
}
