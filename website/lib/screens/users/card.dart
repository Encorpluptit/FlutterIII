import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website/blocs/users/bloc.dart';
import 'package:website/blocs/work_time/bloc.dart';
import 'package:website/models/work_time.dart';
import 'package:website/screens/users/users.dart';
import 'package:website/widgets/work_time/work_time.dart';

class UserCard extends StatefulWidget {
  final List<User> users;
  final int selectedUser;

  const UserCard({Key? key, required this.users, required this.selectedUser})
      : super(key: key);

  @override
  _UserCard createState() => _UserCard();
}

User update(User user, String field, dynamic value) {
  switch (field) {
    case "email":
      user.email = value;
      break;
  }
  return (user);
}

class _UserCard extends State<UserCard> {
  final emailController = TextEditingController();
  List<WorkTimeModel> workTimes = [];

  @override
  Widget build(BuildContext context) {
    var selectedUser = widget.selectedUser;
    var users = widget.users;

    if (selectedUser == -1) {
      return (Card(child: Text('Select a user to see its informations')));
    }
    var user = users[selectedUser];
    emailController.text = user.email;

    return Card(
      child: Column(
        children: <Widget>[
          SizedBox(),
          TextFormField(
            keyboardType: TextInputType.text,
            enabled: false,
            autofocus: false,
            decoration: InputDecoration(
              hintText: 'UID',
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            autofocus: false,
            decoration: InputDecoration(
              hintText: 'Email',
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            ),
          ),
          Container(
            child: TextButton(
              style: TextButton.styleFrom(primary: Colors.blue),
              onPressed: () => {
                user = update(user, "email", emailController.text),
                BlocProvider.of<UsersBloc>(context).add(UsersUpdateEvent(user))
              },
              child: Text('Update',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
          Container(
            child: TextButton(
              style: TextButton.styleFrom(primary: Colors.blue),
              onPressed: () => {
                BlocProvider.of<UserWorkTimeBloc>(context)
                    .add(UserClickOnWorkTimesEvent(user))
              },
              child: Text('Check work times',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
          Container(
            child: BlocListener<UserWorkTimeBloc, UserWorkTimeState>(
              listener: (context, state) {
                if (state is UserWorkTimeWaitingState) {
                  BlocProvider.of<UserWorkTimeBloc>(context)
                      .add(UserClickOnWorkTimesEvent(user));
                }
              },
              child: BlocBuilder<UserWorkTimeBloc, UserWorkTimeState>(buildWhen:
                  (UserWorkTimeState previous, UserWorkTimeState current) {
                if (current is UserWorkTimeWaitingState) {
                  return (false);
                }
                return (true);
              }, builder: (context, state) {
                print(state.toString());
                if (state is UserWorkTimeWaitingState ||
                    state is UserWorkTimeResetState) {
                  return (Container());
                }
                if (state is UserWorkTimesLoadedSuccessState) {}
                if (state is UserWorkTimesLoadedSuccessState ||
                    state is UserWorkTimeUpdateSuccessState) {
                  if (state is UserWorkTimesLoadedSuccessState) {
                    if (state.workTimes.isEmpty ||
                        state.workTimes.length == 0) {
                      return const Center(child: Text('No WorkTime Found'));
                    }
                    workTimes = state.workTimes;
                  }
                  return Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: ListView.builder(
                      itemCount: workTimes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(children: [
                          WorkTime(workTime: workTimes[index]),
                          Divider(),
                        ]);
                      },
                    ),
                  );
                }
                return const Center(child: Text('No WorkTime Found'));
              }),
            ),
          ),
        ],
      ),
    );
  }
}
