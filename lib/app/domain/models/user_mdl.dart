import 'package:hive_flutter/hive_flutter.dart';

part 'user_mdl.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String email;
  @HiveField(2)
  String name;
  @HiveField(3)
  String password;
  @HiveField(4)
  String phone;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.password,
    required this.phone,
  });
}
