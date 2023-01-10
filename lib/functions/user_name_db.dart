import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management/model/user_name_model.dart';

const userName_db_name = 'username-database';

abstract class UserNameDbFunction {
  Future<List<UserNameModel>> getUserName();
  Future<void> addUserName(UserNameModel value);
}

class UserNameDB implements UserNameDbFunction {
  UserNameDB._internal();
  static UserNameDB instance = UserNameDB._internal();
  factory UserNameDB() {
    return instance;
  }
  ValueNotifier<List<UserNameModel>> userNotifier = ValueNotifier([]);
  @override
  Future<void> addUserName(UserNameModel value) async {
    print(value.user);
    final _userDB = await Hive.openBox<UserNameModel>(userName_db_name);
    await _userDB.add(value);
    // print(await _userDB.add(value).toString());
    refreshUserUI();
    // userNotifier.value.add(value);
    // userNotifier.notifyListeners();
  }

  @override
  Future<List<UserNameModel>> getUserName() async {
    final _userDB = await Hive.openBox<UserNameModel>(userName_db_name);
    return _userDB.values.toList();
    // userNotifier.value.addAll(_userDB.values);
    // userNotifier.notifyListeners();
  }

  Future<void> refreshUserUI() async {
    final _fixUserName = await getUserName();
    userNotifier.value.clear();
    await Future.forEach(_fixUserName, (UserNameModel user) {
      userNotifier.value.add(user);
    });
    userNotifier.notifyListeners();
  }
}
