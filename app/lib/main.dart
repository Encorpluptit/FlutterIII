import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetracking/src/blocs/login/bloc.dart';
import 'package:timetracking/src/utils/global.dart' as global;
import 'package:timetracking/src/ui/routes/main_routes.dart';
import 'package:timetracking/src/utils/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) {
      return LoginBloc();
    }),
  ], child: const App()));
}

Future<bool> _loadCredentials() async {
  final auth = await MySharedPreferences().get("AUTH");

  if (auth == null) {
    return (false);
  }

  return (true);
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
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
      global.auth = FirebaseAuth.instanceFor(app: global.app);
      global.store = FirebaseFirestore.instanceFor(app: global.app);
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
      return const MaterialApp(home: Text("Error"));
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return const MaterialApp(home: CircularProgressIndicator());
    }

    return FutureBuilder(
      future: _loadCredentials(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            initialRoute: (snapshot.data == true ? '/home' : '/'),
            title: 'TimeTracking',
            theme: ThemeData(
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
            ),
            home: const MainRoutes(),
          );
        } else {
          return const MaterialApp(
              home: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
