import 'dart:convert';

import 'package:authentication_servicee/repository/user_repo.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final body = await context.request.body();
  final jsonBody = body.isNotEmpty
      ? jsonDecode(body) as Map<String, dynamic>
      : <String, dynamic>{};
  return context.read<UserRepository>().getAllUser(
        page: (jsonBody['page'] as int?) ?? 1,
        limit: (jsonBody['limit'] as int?) ?? 50,
      );
}
