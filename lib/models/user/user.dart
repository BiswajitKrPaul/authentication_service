import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// User Model Class
@JsonSerializable()
class User {
  /// User Model Constructor
  const User(
    this.id,
    this.firstname,
    this.middlename,
    this.lastname,
    this.mobile,
    this.email,
  );

  /// From json function
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// toJson Function
  Map<String, dynamic> toJson() => _$UserToJson(this);

  /// id
  @JsonKey(disallowNullValue: true)
  final String id;

  /// firstname
  final String firstname;

  ///middlename
  final String? middlename;

  /// lastname
  final String lastname;

  /// Mobile no
  final String mobile;

  /// Email
  final String? email;
}

enum UserInfoTable {
  id('id'),
  firstName('firstname'),
  middlename('middlename'),
  lastname('lastname'),
  mobile('mobile'),
  email('email'),
  tableName('user_info');

  const UserInfoTable(this.string);
  final String string;
}
