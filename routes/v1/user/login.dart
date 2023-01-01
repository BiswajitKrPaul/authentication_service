import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:authentication_servicee/repository/user_repo.dart';
import 'package:dart_frog/dart_frog.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  if (context.request.method == HttpMethod.post) {
    final body = await context.request.body();
    final jsonBody = body.isNotEmpty
        ? jsonDecode(body) as Map<String, dynamic>
        : <String, dynamic>{};
    if (jsonBody.isNotEmpty) {
      return context.read<UserRepository>().login(jsonBody);
    } else {
      return Response.json(
        statusCode: HttpStatus.badRequest,
        body: 'Email and Password required',
      );
    }
  }
  return Response(statusCode: HttpStatus.methodNotAllowed);
}
