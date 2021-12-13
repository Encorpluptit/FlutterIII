import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website/blocs/users/bloc.dart';
import 'package:website/blocs/work_time/bloc.dart';
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
                if (state is UserWorkTimesLoadedSuccessState) {
                  if (state.workTimes.isEmpty || state.workTimes.length == 0) {
                    return const Center(child: Text('No WorkTime Found'));
                  }
                  return Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: ListView.builder(
                      itemCount: state.workTimes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(children: [
                          WorkTime(workTime: state.workTimes[index]),
                          Divider(),
                        ]);
                      },
                    ),
                  );
                  // return Container(
                  //   width: MediaQuery.of(context).size.width / 2,
                  //   height: MediaQuery.of(context).size.height / 1.5,
                  //   child: ListView(
                  //     padding: const EdgeInsets.all(8),
                  //     children: <Widget>[
                  //       WorkTime(),
                  //       Container(
                  //         height: 50,
                  //         color: Colors.amber[500],
                  //         child: const Center(child: Text('Entry B')),
                  //       ),
                  //       Container(
                  //         height: 50,
                  //         color: Colors.amber[100],
                  //         child: const Center(child: Text('Entry C')),
                  //       ),
                  //     ],
                  //   ),
                  // );
                }
                return const Center(child: Text('No WorkTime Found'));
                // return Row(
                //   children: [
                //     Text("ok1"),
                //     Text("ok2"),
                //   ],
                // );
                // return               Container(
                //     width: MediaQuery.of(context).size.width / 2,
                //     child: PaginatedDataTable(
                //       showCheckboxColumn: false,
                //       rowsPerPage: 10,
                //       columns: [
                //         DataColumn(label: Text('UUID')),
                //         DataColumn(label: Text('Email')),
                //         DataColumn(label: Text('Email verified')),
                //         DataColumn(label: Text('Account creation date')),
                //       ],
                //       source: _DataSource(
                //           rows: _list,
                //           context: context,
                //           setSelected: (index) =>
                //               BlocProvider.of<UsersBloc>(context)
                //                   .add(UsersClickOnDetailsEvent(index))),
                //     )),

                // return (Container());
                // if (state is UsersLoadedSuccessState) {
                //   List<User> _list = state.users;
                //   return Row(children: <Widget>[
                //     Container(
                //         width: MediaQuery.of(context).size.width / 2,
                //         child: PaginatedDataTable(
                //           showCheckboxColumn: false,
                //           rowsPerPage: 10,
                //           columns: [
                //             DataColumn(label: Text('UUID')),
                //             DataColumn(label: Text('Email')),
                //             DataColumn(label: Text('Email verified')),
                //             DataColumn(label: Text('Account creation date')),
                //           ],
                //           source: _DataSource(
                //               rows: _list,
                //               context: context,
                //               setSelected: (index) =>
                //                   BlocProvider.of<UsersBloc>(context)
                //                       .add(UsersClickOnDetailsEvent(index))),
                //         )),
                //     Container(
                //         height: MediaQuery.of(context).size.height,
                //         width: MediaQuery.of(context).size.width / 2,
                //         child: UserCard(
                //             users: _list, selectedUser: state.selectedUser)),
                //   ]);
                // }
                // return (Container());
              }),
            ),
          ),

          // Container(
          //   child: TextButton(
          //     style: TextButton.styleFrom(primary: Colors.blue),
          //     onPressed: () => {
          //       BlocProvider.of<UsersBloc>(context)
          //           .add(UserClickOnWorkTimesEvent(user))
          //     },
          //     child: Text('Check work times',
          //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          //   ),
          // ),
        ],
      ),
    );
  }
}
