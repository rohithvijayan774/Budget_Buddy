import 'package:hive_flutter/adapters.dart';
part 'user_name_model.g.dart';

@HiveType(typeId: 2)
class UserNameModel {
  @HiveField(0)
  final String user;

  UserNameModel({required this.user});
}
