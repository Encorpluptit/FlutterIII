import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

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
    _email_verified = result['emailVerified'] as bool;
    _creation_date = result['metadata']['creationTime'];
  }

  String get uuid => _uuid;
  String get email => _email;
  bool get emailVerified => _email_verified;
  String get creationDate => _creation_date;
}

class UsersListPage extends StatefulWidget {
  const UsersListPage({Key? key}) : super(key: key);

  @override
  _FormMaterialState createState() => _FormMaterialState();
}

class _FormMaterialState extends State<UsersListPage> {
  Future<List<User>> _getUsers() async {
    HttpsCallable callable =
        await FirebaseFunctions.instanceFor(region: 'europe-west2')
            .httpsCallable('getAllUsers');
    final results = await callable.call();
    final res = jsonDecode(results.data);

    List<User> _list = [];

    for (var i = 0; i != res.length; i++) {
      print(res[i]);
      _list.add(User.fromJSON(res[i]));
    }
    return (_list);
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
            return Container(
                child: PaginatedDataTable(
              rowsPerPage: 10,
              columns: [
                DataColumn(label: Text('UUID')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Email verified')),
                DataColumn(label: Text('Account creation date')),
              ],
              source: _DataSource(_list, context),
            ));
          }
        });
  }
}

class _Row {
  _Row(
    this.valueA,
    this.valueB,
    this.valueC,
    this.valueD,
  );

  final String valueA;
  final String valueB;
  final String valueC;
  final int valueD;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(list, this.context) {
    _rows = list;
  }

  final BuildContext context;
  late List<User> _rows;

  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return null;
    final row = _rows[index];
    return DataRow.byIndex(
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
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
