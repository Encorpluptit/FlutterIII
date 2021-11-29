import 'package:flutter/material.dart';
import 'package:website/screens/forms/form.dart';
import 'package:website/utils/color_constants.dart';

class NavigationRouteInterface {
  final Icon icon;
  final String label;
  final Widget widget;
  const NavigationRouteInterface(this.icon, this.label, this.widget);
}

const List<NavigationRouteInterface> navigationRoutes = [
  NavigationRouteInterface(Icon(Icons.home), "Home", FormPage()),
  NavigationRouteInterface(Icon(Icons.home), "Home 2", FormPage()),
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
      appBar: AppBar(
        automaticallyImplyLeading:
            MediaQuery.of(context).size.width < 1300 ? true : false,
        title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  "Time tracking",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ]),
        actions: <Widget>[
          Container(
            child: IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          SizedBox(width: 32),
        ],
        backgroundColor: ColorConstants.blue,
        // automaticallyImplyLeading: false,
      ),
      body: Row(
        children: <Widget>[
          MediaQuery.of(context).size.width < 1300
              ? Container()
              : Card(
                  elevation: 2.0,
                  child: Container(
                      margin: EdgeInsets.all(0),
                      height: MediaQuery.of(context).size.height,
                      width: 300,
                      color: Colors.white,
                      child: listDrawerItems()),
                ),
          Container(
            width: MediaQuery.of(context).size.width < 1300
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.width - 310,
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: tabController,
              children: navigationRoutes
                  .map<Widget>((route) => route.widget)
                  .toList(),
            ),
          )
        ],
      ),
      drawer: Padding(
          padding: EdgeInsets.only(top: 56),
          child: Drawer(child: listDrawerItems())),
    );
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
