import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:website/utils/global.dart' as global;

import 'card.dart';

class User {
  String _uuid = "";
  String _email = "";
  bool _email_verified = false;
  String _creation_date = "";

  User({required String uuid, required String email}) {
    _uuid = uuid;
    _email = email;
  }

  User.fromJSON(Map<String, dynamic> result) {
    _uuid = result['uid'];
    _email = result['email'];
  }

  String get uuid => _uuid;
  String get email => _email;
  bool get emailVerified => _email_verified;
  String get creationDate => _creation_date;
}

class UsersListPage extends StatefulWidget {
  const UsersListPage({Key? key}) : super(key: key);

  @override
  _UsersListPage createState() => _UsersListPage();
}

class _UsersListPage extends State<UsersListPage> {
  int selectedUser = -1;

  Future<List<User>> _getUsers() async {
    final users =
        FirebaseFirestore.instanceFor(app: global.app).collection("users");
    final query = await users.get().catchError((error) => print(error));
    final allData = query.docs.map((doc) => doc.data()).toList();
    List<User> _list = [];

    for (var i = 0; i != allData.length; i++) {
      _list.add(User.fromJSON(allData[i]));
    }
    return (_list);
  }

  void setSelected(int number) {
    setState(() {
      selectedUser = number;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getUsers(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            List<User> _list = snapshot.data;
            return Row(children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: PaginatedDataTable(
                    showCheckboxColumn: false,
                    rowsPerPage: 10,
                    columns: [
                      DataColumn(label: Text('UUID')),
                      DataColumn(label: Text('Email')),
                      DataColumn(label: Text('Email verified')),
                      DataColumn(label: Text('Account creation date')),
                    ],
                    source: _DataSource(
                        rows: _list,
                        context: context,
                        setSelected: setSelected),
                  )),
              Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width / 2,
                  child: UserCard(users: _list, selectedUser: selectedUser)),
            ]);
          }
        });
  }
}

class _DataSource extends DataTableSource {
  _DataSource(
      {required this.rows, required this.context, required this.setSelected});

  final BuildContext context;
  late List<User> rows;
  late Function setSelected;

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    final row = rows[index];
    return DataRow.byIndex(
      onSelectChanged: (value) => setSelected(index),
      index: index,
      cells: [
        DataCell(Text(row.uuid)),
        DataCell(Text(row.email)),
        DataCell(Text(row.emailVerified.toString())),
        DataCell(Text(row._creation_date)),
      ],
    );
  }

  @override
  int get rowCount => rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
