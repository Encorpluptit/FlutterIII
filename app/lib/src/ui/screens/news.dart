import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetracking/src/blocs/news/bloc.dart';
import 'package:timetracking/src/ui/widgets/news_page.dart';
import 'package:timetracking/src/ui/widgets/news_error.dart';
import 'package:timetracking/src/ui/widgets/news_loading.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<NewsBloc, NewsState>(
        listener: (context, state) async {},
        child: BlocBuilder<NewsBloc, NewsState>(
            buildWhen: (NewsState previous, NewsState current) {
          return (true);
        }, builder: (context, state) {
          if (state is NewsLoadedFailure) {
            return (NewsErrorPage(
              error: state.error,
            ));
          } else if (state is NewsLoggedIn) {
            return (NewsPage(
              newsData: state.newsData,
            ));
          } else if (state is NewsLoading) {
            return (const NewsLoadingPage());
          } else {
            return (Container());
          }
        }),
      ),
    );
  }
}
