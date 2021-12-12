import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website/blocs/users/bloc.dart';
import 'package:website/blocs/work_time/bloc.dart';
import 'package:website/routes/private_route.dart';
import 'package:website/screens/layout.dart';
import 'package:website/screens/login/login.dart';
import 'package:website/utils/global.dart' as global;
import 'package:website/utils/shared_preferences.dart';

import 'blocs/login/bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) {
      return LoginBloc();
    }),
    BlocProvider(create: (context) {
      return UsersBloc();
    }),
    BlocProvider(create: (context) {
      return UserWorkTimeBloc();
    }),
  ], child: App()));
}

Future<bool> _loadCredidendials() async {
  final auth = await MySharedPreferences().get("AUTH");

  if (auth == null) {
    return (false);
  }

  return (true);
}

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      global.app = await Firebase.initializeApp();
      global.auth = await FirebaseAuth.instanceFor(app: global.app);
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      return Text("Error");
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return CircularProgressIndicator();
    }

    Map<String, WidgetBuilder> routes = {
      '/': (BuildContext context) => PrivateRoute(false, Login()),
      '/home': (BuildContext context) => PrivateRoute(true, HomeScreen()),
    };

    return FutureBuilder(
      future: _loadCredidendials(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
              initialRoute: (snapshot.data == true ? '/home' : '/'),
              routes: routes,
              title: 'TimeTracking',
              theme: ThemeData(
                brightness: Brightness.light,
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
              ));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
