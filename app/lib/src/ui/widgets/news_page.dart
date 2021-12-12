import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timetracking/src/ui/themes/themes.dart';
import 'package:timetracking/src/models/news.dart';

class NewsPage extends StatefulWidget {
  final List<NewsData> newsData;
  const NewsPage({Key? key, required this.newsData}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
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
          Expanded(
            child: ListView.builder(
                itemCount: widget.newsData.length,
                itemBuilder: (context, index) {
                  return Card(
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
                            widget.newsData[index].title!,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            DateFormat('dd/MM/yyy – HH:mm').format(widget
                                    .newsData[index].createdAt!
                                    .toDate()) +
                                '\n\n' +
                                widget.newsData[index].content!,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
