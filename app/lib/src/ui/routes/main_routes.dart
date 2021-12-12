import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetracking/src/blocs/account/bloc.dart';
import 'package:timetracking/src/blocs/news/bloc.dart';
import 'package:timetracking/src/blocs/time_manager/bloc.dart';
import 'package:timetracking/src/blocs/work_times_manager/bloc.dart';
import 'package:timetracking/src/ui/screens/account.dart';
import 'package:timetracking/src/ui/screens/news.dart';
import 'package:timetracking/src/ui/screens/time_manager.dart';
import 'package:timetracking/src/ui/screens/work_times_manager.dart';

class NavigationRouteInterface {
  final Icon icon;
  final String label;
  final Widget widget;
  const NavigationRouteInterface(this.icon, this.label, this.widget);
}

List<NavigationRouteInterface> navigationRoutes = [
  NavigationRouteInterface(
      const Icon(Icons.person),
      "News",
      BlocProvider(
        create: (_) => NewsBloc(),
        child: const NewsScreen(),
      )),
  NavigationRouteInterface(
      const Icon(Icons.person),
      "All work times",
      BlocProvider(
        create: (_) => WorkTimesManagerBloc(),
        child: const WorkTimesManagerScreen(),
      )),
  NavigationRouteInterface(
      const Icon(Icons.person),
      "Clock in & out",
      BlocProvider(
        create: (_) => TimeManagerBloc(),
        child: const TimeManagerScreen(),
      )),
  NavigationRouteInterface(
      const Icon(Icons.person),
      "Account",
      BlocProvider(
        create: (_) => AccountBloc(),
        child: const AccountScreen(),
      )),
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

  void _onItemTapped(int index) async {
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
            onTap: _onItemTapped),
        body: Center(child: navigationRoutes.elementAt(_selectedIndex).widget));
  }
}
