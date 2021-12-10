import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timetracking/src/blocs/work_times_manager/bloc.dart';
import 'package:timetracking/src/ui/widgets/work_times_manager_error.dart';
import 'package:timetracking/src/ui/widgets/work_times_manager_loading.dart';
import 'package:timetracking/src/ui/widgets/work_times_manager_logged.dart';

class WorkTimesManagerScreen extends StatefulWidget {
  const WorkTimesManagerScreen({Key? key}) : super(key: key);

  @override
  _WorkTimesManagerScreenState createState() => _WorkTimesManagerScreenState();
}

class _WorkTimesManagerScreenState extends State<WorkTimesManagerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<WorkTimesManagerBloc, WorkTimesManagerState>(
        listener: (context, state) async {},
        child: BlocBuilder<WorkTimesManagerBloc, WorkTimesManagerState>(
            buildWhen: (WorkTimesManagerState previous,
                WorkTimesManagerState current) {
          return (true);
        }, builder: (context, state) {
          if (state is WorkTimesManagerError) {
            return (WorkTimesManagerErrorPage(
              error: state.error,
            ));
          } else if (state is WorkTimesManagerLoggedIn) {
            return (WorkTimesManagerLoggedInPage(workTimes: state.workTimes));
          } else if (state is WorkTimesManagerLoading) {
            return (const WorkTimesManagerLoadingPage());
          } else {
            return (Container());
          }
        }),
      ),
    );
  }
}
