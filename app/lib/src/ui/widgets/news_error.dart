import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsErrorPage extends StatefulWidget {
  final String error;
  const NewsErrorPage({Key? key, required this.error})
      : super(key: key);

  @override
  _NewsErrorPageState createState() =>
      _NewsErrorPageState();
}

class _NewsErrorPageState extends State<NewsErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
            child: Center(child: Text(widget.error))));
  }
}
