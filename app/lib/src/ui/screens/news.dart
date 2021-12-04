import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetracking/src/blocs/news/bloc.dart';
/* import 'package:timetracking/src/blocs/register/register_bloc.dart'; */
/* import 'package:timetracking/src/ui/screens/register.dart'; */
import 'package:timetracking/src/ui/widgets/news_page.dart';

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
        listener: (context, state) {
          if (state is NewsLoadedFailure) {
            const snackBar = SnackBar(
              duration: Duration(minutes: 5),
              content: Text('Error loadind news.'),
              backgroundColor: Colors.red,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
         /*  if (state is LoginToRegister) {
            // print("LoginToRegisterOK");
            BlocProvider.of<LoginBloc>(context).add(LoginToRegisterDoneEvent());
            Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                    builder: (context) => BlocProvider(
                          create: (_) => RegisterBloc(),
                          child: const RegisterScreen(),
                        )));
          } */
        },
        child: BlocBuilder<NewsBloc, NewsState>(
            buildWhen: (NewsState previous, NewsState current) {
          return (true);
        }, builder: (context, state) {
          if (state is NewsOnPage) {
            return (const NewsPage());
          } else if (state is NewsLoading) {
            return (const Center(
              child: CircularProgressIndicator(),
            ));
          } else if (state is NewsLoadedFailure) {
            return (Container());
          } else {
            return (Container());
          }
        }),
      ),
    );
  }
}
