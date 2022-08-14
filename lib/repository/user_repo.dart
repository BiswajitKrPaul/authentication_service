import 'dart:async';
import 'dart:convert';

import 'package:authentication_servicee/models/user/user.dart';
import 'package:authentication_servicee/services/db_service.dart';

/// User Repository
class UserRepository {
  final String _table = 'user_info';
  final String _id = 'id';
  final String _firstname = 'firstname';
  final String _middlename = 'middlename';
  final String _lastname = 'lastname';
  final String _mobile = 'mobile';
  final String _email = 'email';

  final _connection = ref.read(databaseProvider);

  /// Get All User
  FutureOr<dynamic> getAllUser() async {
    final results = await _connection.query(
      'select'
      ' $_id,$_firstname,$_middlename,$_lastname,$_mobile,$_email from $_table',
    );

    final _users = List<Map<String, dynamic>>.empty(growable: true);

    for (final row in results) {
      final user = User.fromJson(row.toColumnMap());
      _users.add(user.toJson());
    }
    return json.decode(jsonEncode(_users));
  }
}
