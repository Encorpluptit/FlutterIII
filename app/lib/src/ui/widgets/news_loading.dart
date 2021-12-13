import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetracking/src/blocs/news/bloc.dart';
import 'package:timetracking/src/utils/shared_preferences.dart';

class NewsLoadingPage extends StatefulWidget {
  const NewsLoadingPage({Key? key}) : super(key: key);

  @override
  _NewsLoadingPageState createState() => _NewsLoadingPageState();
}

class _NewsLoadingPageState extends State<NewsLoadingPage> {
  @override
  Widget build(BuildContext context) {
    MySharedPreferences().get("USER_EMAIL").then((email) {
      if (email != null && email.isNotEmpty) {
        BlocProvider.of<NewsBloc>(context).add(const NewsLoadEvent());
      } else {
        BlocProvider.of<NewsBloc>(context)
            .add(const NewsLoadErrorEvent("Please login first"));
      }
    });
    return Center(
      child: Column(
        children: const [CircularProgressIndicator(), Text("Loading")],
      ),
    );
  }
}
