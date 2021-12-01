import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website/blocs/login/bloc.dart';
import 'package:website/screens/users/users.dart';
import 'package:website/widgets/appbar.dart';

class NavigationRouteInterface {
  final Icon icon;
  final String label;
  final Widget widget;
  const NavigationRouteInterface(this.icon, this.label, this.widget);
}

const List<NavigationRouteInterface> navigationRoutes = [
  NavigationRouteInterface(Icon(Icons.home), "Users", UsersListPage()),
  NavigationRouteInterface(Icon(Icons.home), "Home 2", UsersListPage()),
];

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    tabController = new TabController(
        vsync: this, length: navigationRoutes.length, initialIndex: 0);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    tabController.animateTo(index);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HomeAppBar(),
        drawer: Padding(
            padding: EdgeInsets.only(top: kToolbarHeight),
            child: Drawer(child: listDrawerItems())),
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginLogoutState) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/', (route) => false);
            }
          },
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: tabController,
            children:
                navigationRoutes.map<Widget>((route) => route.widget).toList(),
          ),
        ));
  }

  Widget listDrawerItems() {
    return ListView(
      children: navigationRoutes.map<Widget>((route) {
        var currentIndex = navigationRoutes.indexOf(route);

        return (TextButton(
          style: TextButton.styleFrom(
            primary: currentIndex == _selectedIndex ? Colors.blue : Colors.grey,
          ),
          onPressed: () => _onItemTapped(currentIndex),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(top: 22, bottom: 22, right: 22),
              child: Row(children: [
                route.icon,
                Text(
                  route.label,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'HelveticaNeue',
                  ),
                ),
              ]),
            ),
          ),
        ));
      }).toList(),
    );
  }
}
