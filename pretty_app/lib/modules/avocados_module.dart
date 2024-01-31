import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AvocadoModel {
  final int id;
  final String name;
  final double price;
  final int amount;

  AvocadoModel({
    required this.id,
    required this.name,
    required this.price,
    required this.amount,
  });

  factory AvocadoModel.fromJson(Map<String, dynamic> jsonData) {
    // return switch (jsonData) {
    //   {
    //     'id': String id,
    //     'name': String name,
    //     'price': String price,
    //     'amount': String amount,
    //   } =>
    //     AvocadoModel(
    //       id: int.parse(id),
    //       name: name,
    //       price: double.parse(price),
    //       amount: int.parse(amount),
    //     ),
    //   _ => throw const FormatException("Failed to load avocado")
    // };

    return AvocadoModel(
      id: int.parse(jsonData['id'].toString()),
      name: jsonData['name'].toString(),
      price: double.parse(jsonData['price'].toString()),
      amount: int.parse(jsonData['amount'].toString()),
    );
  }
}

class AvocadoAPI extends ChangeNotifier {
  static const _baseURL = 'http://10.0.2.2:5000/avocado/';

  Future<AvocadoModel> getAvocado(String id) async {
    final response = await http.get(Uri.parse('$_baseURL$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load avocado');
    }

    return AvocadoModel.fromJson(response.body as Map<String, dynamic>);
  }

  Future<List<AvocadoModel>> getAvocados() async {
    final response = await http.get(Uri.parse(_baseURL));

    if (response.statusCode != 200) {
      throw Exception('Failed to load avocado');
    }

    List<AvocadoModel> avocados = List.empty(growable: true);
    dynamic decoded = jsonDecode(response.body);

    for (Map<String, dynamic> data in decoded['data']) {
      avocados.add(AvocadoModel.fromJson(data));
    }

    return avocados;
  }
}