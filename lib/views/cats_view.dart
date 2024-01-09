import 'package:cu/modules/cats_api.dart';
import 'package:cu/widgets/nav_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CatsView extends StatefulWidget {
  const CatsView({super.key});

  @override
  State<CatsView> createState() => _CatsViewState();
}

class _CatsViewState extends State<CatsView> {
  CatFactsModel? _catsFact;
  bool _isLoading = false;

  Future<void> loadCatsFact() async {
    final catsService = CatsApi();

    setState(() => _isLoading = true);
    _catsFact = await catsService.getCatsFact().catchError((error) {
      if (kDebugMode) {
        print("Failed to fetch fact");
      }

      return Future(() => null);
    });
    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();

    loadCatsFact();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return scaffold(const CircularProgressIndicator());
    }

    return scaffold(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _catsFact?.fact ?? 'Fact not found',
            textAlign: TextAlign.center,
          ),
          Text(
            _catsFact?.length.toString() ?? 'no length',
            textAlign: TextAlign.center,
          )
        ],
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
}
