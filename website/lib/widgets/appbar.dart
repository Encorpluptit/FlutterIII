import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website/blocs/login/bloc.dart';

class HomeAppBar extends StatefulWidget with PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  _HomeAppBarState createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
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
              BlocProvider.of<LoginBloc>(context).add(LoginLogoutEvent());
            },
          ),
        ),
      ],
    );
  }
}
