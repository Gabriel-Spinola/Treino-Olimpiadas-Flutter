import 'package:flutter/material.dart';
import 'package:pretty_app/modules/avocados_module.dart';

class AvocadoItemTile extends StatelessWidget {
  final AvocadoModel model;

  const AvocadoItemTile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(model.id.toString()),
      Text(model.name),
      Text(model.price.toString()),
      Text(model.amount.toString()),
    ],);
  }
}