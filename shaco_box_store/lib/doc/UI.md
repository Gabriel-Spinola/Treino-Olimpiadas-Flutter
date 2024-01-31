# Flutter Widgets
## Stack
Used for overlapping components
```dart
Stack(
  children: const [],
)
```

## Flex
Main axis for horizontal movement
Cross axis for vertical movement

## List View
Used to handle list of widgets, also comes with garbage collection; cleaning, if
necessary, already scrolled widgets

To avoid performSize() assertions, consider adding both the scrollDirection and 
shrinkWrap properties

## Realtime changes
Using the stream from the async api, you can achieve realtime builders for UI
```dart
StreamBuilder<QuerySnapshot>(
  stream: someStream,
  builder (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    ...
  }
)
```

using future builder the changes will only reload when the page also reloads

## Routing
The method I'm using is to have a seperate AppRoutes class, containing the all the routes
and an index representing the current selected route. Then we use then to match
into the routes field from MaterialApp

### Example
```dart
class AppRoutes {
  static const home = '/';
  static const otherRoute = '/other-route';
  ...

  static final List<String> routes = <String>[home, otherRoute, ...];

  static int selectedIndex = 0;
}
```

```dart
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      ...
      routes: {
        // Match the route name with the corresponding class
        AppRoutes.home: (_) => const HomeView(),
        AppRoutes.otherRoute: (_) => const OtherRouteView(),
        ...
      },
    );
  }
```

For navigation I'm using the Navigator API `Navigator.of(context);`,
example of Navigation bar:
```dart
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

    // Pop the current route
    Navigator.of(context).pop(AppRoutes.routes);

    // Push the new selected route
    Navigator.of(context).pushNamed(AppRoutes.routes[AppRoutes.selectedIndex]);
  }

  @override
  Widget build(BuildContext context) {
    // Creates navigation bar
    return BottomNavigationBar(
      currentIndex: AppRoutes.selectedIndex,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.catching_pokemon), label: 'other'),
      ],
      onTap: _onItemTapped,
    );
  }
}
```

## Stateful Methods
```dart
@override
void initState() {
  super.initState();

  // Initialization
}

// Runs when widget is removed from the UI
@override
void dispose() {
  super.dispose();
  
  // Dispose implementation
}
```

## Dialog
```dart
showDialog(context: context, builder: (context) => AlertDialog());
```

## Grids
In order to create grid use the GridView.builder

SliverGridDelegateWithFixedCrossAxisCount makes it so we can hae a limited amount of item in the cross axis

We can add a Expanded so the list is scrollable and avoid sizing errors