import 'package:flutter/material.dart';
import 'package:website/screens/home/home_screen.dart';
import 'package:website/utils/color_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:website/utils/shared_preferences.dart';

Future<bool> _login() async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: "acazalet@protonmail.com", password: "azeaze");
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
    return (false);
  }
  final auth = await MySharedPreferences()
      .set("AUTH", FirebaseAuth.instance.currentUser!.uid);
  return (true);
}

class Login extends StatefulWidget {
  Login({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      initialValue: '',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    );

    final loginButton = Container(
      child: TextButton(
        style: TextButton.styleFrom(primary: Colors.blue),
        onPressed: () => {
          _login().then((value) => {
                if (value == true)
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    )
                  }
              })
        },
        child: Text('Log In',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: ColorConstants.blue,
              ),
            ],
          ),
          Center(
            child: Card(
              elevation: 2.0,
              child: Container(
                padding: EdgeInsets.all(42),
                width: MediaQuery.of(context).size.width / 2.5,
                height: MediaQuery.of(context).size.height / 1.5,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 62.0),
                    Center(
                        child: Text(
                      "Time tracking",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    SizedBox(height: 48.0),
                    email,
                    SizedBox(height: 8.0),
                    password,
                    SizedBox(height: 24.0),
                    loginButton,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
