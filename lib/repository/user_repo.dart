import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:authentication_servicee/models/user/user.dart';
import 'package:authentication_servicee/query_builder/query_builder.dart';
import 'package:authentication_servicee/services/db_service.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';

/// User Repository
class UserRepository {
  final _connection = ref.read(databaseProvider);

  /// Get All User
  FutureOr<Response> getAllUser({int? page = 1, int? limit = 10}) async {
    final queryBuilder = QueryBuilder.paginatedSelect(
      columnNames: [
        UserInfoTable.id.string,
        UserInfoTable.firstName.string,
        UserInfoTable.lastname.string,
        UserInfoTable.mobile.string,
        UserInfoTable.middlename.string,
        UserInfoTable.email.string
      ],
      tableName: UserInfoTable.tableName.string,
      pageNo: page ?? 1,
      limit: limit ?? 10,
    );

    try {
      final _users = List<Map<String, dynamic>>.empty(growable: true);
      final query = queryBuilder.buildQuery();
      if (query != null) {
        final results = await _connection.query(query);
        for (final row in results) {
          final user = User.fromJson(row.toColumnMap());
          _users.add(user.toJson());
        }
        return Response.json(
          body: {
            'users': json.decode(jsonEncode(_users)),
            'page': page,
            'limit': limit,
            'total':
                results.isNotEmpty ? results.first.toColumnMap()['count'] : 0,
          },
        );
      }
    } on PostgreSQLException catch (e) {
      return Response.json(
        statusCode: HttpStatus.badRequest,
        body: {'error': e.message},
      );
    } on Exception {
      return Response.json(
        statusCode: HttpStatus.badRequest,
        body: {'error': 'Server Not Responding'},
      );
    }

    return Response(statusCode: HttpStatus.requestTimeout);
  }

  Future<Response> createUser(Map<String, dynamic> jsonBody) async {
    final queryBuilder = QueryBuilder.insert(
      columnNames: [
        UserInfoTable.firstName.string,
        UserInfoTable.lastname.string,
        UserInfoTable.mobile.string,
        UserInfoTable.middlename.string,
        UserInfoTable.email.string
      ],
      columnValues: [
        jsonBody[UserInfoTable.firstName.string],
        jsonBody[UserInfoTable.lastname.string],
        jsonBody[UserInfoTable.mobile.string],
        jsonBody[UserInfoTable.middlename.string],
        jsonBody[UserInfoTable.email.string],
      ],
      tableName: UserInfoTable.tableName.string,
    );
    try {
      final query = queryBuilder.buildQuery();
      if (query != null) {
        await _connection.query(query);
        return Response(
          statusCode: HttpStatus.created,
          body: 'Created',
        );
      }
    } on PostgreSQLException catch (e) {
      return Response.json(
        statusCode: HttpStatus.badRequest,
        body: {'error': e.message},
      );
    } on Exception {
      return Response.json(
        statusCode: HttpStatus.badRequest,
        body: {'error': 'Server Not Responding'},
      );
    }
    return Response(statusCode: HttpStatus.requestTimeout);
  }
}
