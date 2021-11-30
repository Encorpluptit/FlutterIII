import 'package:flutter/material.dart';
import 'package:timetracking/src/ui/screens/home.dart';
import 'package:timetracking/src/ui/screens/login.dart';

class NavigationRouteInterface {
  final Icon icon;
  final String label;
  final Widget widget;
  const NavigationRouteInterface(this.icon, this.label, this.widget);
}

const List<NavigationRouteInterface> navigationRoutes = [
  NavigationRouteInterface(Icon(Icons.home), "Home", HomeScreen()),
  NavigationRouteInterface(Icon(Icons.home), "Home2", HomeScreen()),
  NavigationRouteInterface(Icon(Icons.home), "Account", LoginScreen()),
];

class MainRoutes extends StatefulWidget {
  const MainRoutes({Key? key}) : super(key: key);

  @override
  HomeMainRouteState createState() => HomeMainRouteState();
}

class HomeMainRouteState extends State<MainRoutes> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: navigationRoutes.map<BottomNavigationBarItem>((route) {
            return (BottomNavigationBarItem(
              icon: route.icon,
              label: route.label,
            ));
          }).toList(),
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
        ),
        body: Center(child: navigationRoutes.elementAt(_selectedIndex).widget));
  }
}
