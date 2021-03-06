import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:website/screens/users/users.dart';
import 'package:website/utils/global.dart' as global;

part 'event.dart';
part 'state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersWaitingState()) {
    on<UsersWaitingEvent>((event, emit) => emit(UsersWaitingState()));
    on<UsersLoadEvent>((event, emit) async => emit(await _usersRequest()));
    on<UsersClickOnDetailsEvent>((event, emit) async =>
        emit(await _usersRequest(selectedUser: event.selectedUser)));
    on<UsersUpdateEvent>(
        (event, emit) async => emit(await _usersUpdate(event.user)));
  }

  Future<UsersState> _usersRequest({int selectedUser = -1}) async {
    final users =
        FirebaseFirestore.instanceFor(app: global.app).collection("users");
    final query = await users.get().catchError((error) => print(error));
    final allData = query.docs.map((doc) => doc.data()).toList();
    List<User> _list = [];

    for (var i = 0; i != allData.length; i++) {
      _list.add(User.fromJSON(allData[i]));
    }
    return (UsersLoadedSuccessState(_list, selectedUser: selectedUser));
  }

  Future<UsersState> _usersUpdate(User user) async {
    final collection = FirebaseFirestore.instanceFor(app: global.app)
        .collection("users")
        .doc(user.uuid);
    collection.update({
      "email": user.email,
    });
    return (UsersWaitingState());
  }
}
