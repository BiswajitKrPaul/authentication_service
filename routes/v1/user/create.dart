import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:authentication_servicee/models/user/user.dart';
import 'package:authentication_servicee/query_builder/query_builder.dart';
import 'package:authentication_servicee/services/db_service.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  if (context.request.method == HttpMethod.post) {
    return await _postMethod(context);
  } else {
    return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _postMethod(RequestContext context) async {
  final body = await context.request.body();
  final jsonBody = jsonDecode(body) as Map<String, dynamic>;
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
      await ref.read(databaseProvider).query(query);
      return Response(
        statusCode: HttpStatus.created,
        body: 'Created',
      );
    }
  } on PostgreSQLException catch (e) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: {'error': e.constraintName},
    );
  }
  return Response(statusCode: HttpStatus.requestTimeout);
}
