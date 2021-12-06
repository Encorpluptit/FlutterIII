import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetracking/src/blocs/news/bloc.dart';
import 'package:timetracking/src/ui/themes/themes.dart';
import 'package:timetracking/src/ui/widgets/big_button.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<Map<String, dynamic>> newsData = [
    {"title": "HelloJPNFEPKJNVJPENVJENZEVIJNEIVN", "content": "helloeOKFEOIJFOIEJFIOEJFOIJSFJSIPJFE9ESJSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS","groups": ["Manager", "User"],"date": "13/07/2021"},
    {"title": "Hello", "content": "hello","groups": ["Manager", "User"],"date": "13/07/2021"},
    {"title": "Hello", "content": "hello","groups": ["Manager", "User"],"date": "13/07/2021"},
    {"title": "Hello", "content": "hello","groups": ["Manager", "User"],"date": "13/07/2021"},
    {"title": "Hello", "content": "hello","groups": ["Manager", "User"],"date": "13/07/2021"},
    {"title": "Hello", "content": "hello","groups": ["Manager", "User"],"date": "13/07/2021"},
    {"title": "Hello", "content": "hello","groups": ["Manager", "User"],"date": "13/07/2021"},
    {"title": "Hello", "content": "hello","groups": ["Manager", "User"],"date": "13/07/2021"},
    {"title": "Hello", "content": "hello","groups": ["Manager", "User"],"date": "13/07/2021"},
    {"title": "Hello", "content": "hello","groups": ["Manager", "User"],"date": "13/07/2021"}
  ];
  /* bool passwordVisible = false;
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }
 */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'News',
                style: heading2.copyWith(color: black),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ), 
          Expanded (
            child:ListView.builder(
              itemCount: newsData.length,
              itemBuilder: (context, index) {
                return Card (
                  color: Colors.white,
                  elevation: 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Divider(
                        color: Colors.black,
                        height: 20,
                        thickness: 1,
                        indent: 5,
                        endIndent: 5,
                      ),
                      ListTile(
                        title: Text(
                          newsData[index]['title'],
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            
                          ),
                        ),
                        subtitle: Text(
                          newsData[index]['date']+'\n\n'+newsData[index]['content'],
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}
