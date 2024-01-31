import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pretty_app/modules/avocados_module.dart';

class AvocadoItemTile extends StatelessWidget {
  final AvocadoModel model;

  const AvocadoItemTile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.green[100],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'lib/assets/avocado.png',
              height: 64.0,
            ),
            Text(model.name),
            MaterialButton(
              color: Colors.green,
              child: Text('R\$${model.price.toString()}'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
