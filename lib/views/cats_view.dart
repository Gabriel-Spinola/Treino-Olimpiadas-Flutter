import 'package:cu/modules/cats_api.dart';
import 'package:cu/widgets/nav_bar.dart';
import 'package:flutter/material.dart';

class CatsView extends StatefulWidget {
  const CatsView({super.key});

  @override
  State<CatsView> createState() => _CatsViewState();
}

class _CatsViewState extends State<CatsView> {
  late Future<CatFactsModel> _catsFact;

  @override
  void initState() {
    super.initState();

    var catsService = CatsApi();
    _catsFact = catsService.getCatsFact();
  }

  @override
  Widget build(BuildContext context) {
    return scaffold(
      FutureBuilder<CatFactsModel>(
        future: _catsFact,
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
    );
  }

  Widget scaffold(Widget body) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Center(child: body),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }

  Widget dataColumn(CatFactsModel data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(data.fact),
        Text(data.length.toString()),
      ],
    );
  }
}
