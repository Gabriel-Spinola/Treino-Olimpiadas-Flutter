import 'package:cu/routes/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  void _onItemTapped(int index) {
    if (AppRoutes.selectedIndex == index) {
      return;
    }

    setState(() => AppRoutes.selectedIndex = index);

    Navigator.of(context).pop(AppRoutes.routes);
    Navigator.of(context).pushNamed(AppRoutes.routes[AppRoutes.selectedIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: AppRoutes.selectedIndex,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.catching_pokemon), label: 'cats'),
      ],
      onTap: _onItemTapped,
    );
  }
}
