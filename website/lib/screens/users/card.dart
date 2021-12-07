import 'package:flutter/material.dart';
import 'package:website/screens/users/users.dart';

class UserCard extends StatefulWidget {
  final List<User> users;
  final int selectedUser;
  const UserCard({Key? key, required this.users, required this.selectedUser})
      : super(key: key);

  @override
  _UserCard createState() => _UserCard();
}

class _UserCard extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    var selectedUser = widget.selectedUser;
    var users = widget.users;

    if (selectedUser == -1) {
      return (Card(child: Text('Select a user to see its informations')));
    }
    var user = users[selectedUser];
    return Card(
        child: Column(
      children: <Widget>[
        SizedBox(),
        Text("UID: ${user.uuid}\n"),
        Text("Email: ${user.email}\n"),
        Text("Role: ${user.role}\n"),
      ],
    ));
  }
}
