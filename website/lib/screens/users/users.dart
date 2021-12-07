import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website/blocs/users/bloc.dart';
import 'package:website/utils/global.dart' as global;

import 'card.dart';

class User {
  String _uuid = "";
  String _email = "";
  bool _email_verified = false;
  String _creation_date = "";
  String _role = "User";

  User({required String uuid, required String email, required String role}) {
    _uuid = uuid;
    _email = email;
    _role = role;
  }

  User.fromJSON(Map<String, dynamic> result) {
    _uuid = result['uid'];
    _email = result['email'];
    _role = result['role'];
  }

  String get uuid => _uuid;
  String get email => _email;
  bool get emailVerified => _email_verified;
  String get creationDate => _creation_date;
  String get role => _role;
}

class UsersListPage extends StatefulWidget {
  const UsersListPage({Key? key}) : super(key: key);

  @override
  _UsersListPage createState() => _UsersListPage();
}

class _UsersListPage extends State<UsersListPage> {
  @override
  void initState() {
    BlocProvider.of<UsersBloc>(context).add(UsersLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UsersBloc, UsersState>(
        listener: (context, state) {},
        child: BlocBuilder<UsersBloc, UsersState>(
            buildWhen: (UsersState previous, UsersState current) {
          return (true);
        }, builder: (context, state) {
          if (state is UsersWaitingState) {
            return (Container());
          }
          if (state is UsersLoadedSuccessState) {
            List<User> _list = state.users;
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
                        setSelected: (index) =>
                            BlocProvider.of<UsersBloc>(context)
                                .add(UsersClickOnDetailsEvent(index))),
                  )),
              Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width / 2,
                  child:
                      UserCard(users: _list, selectedUser: state.selectedUser)),
            ]);
          }
          return (Container());
        }),
      ),
    );
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
