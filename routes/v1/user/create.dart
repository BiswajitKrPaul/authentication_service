import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:authentication_servicee/repository/user_repo.dart';
import 'package:dart_frog/dart_frog.dart';

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
  return context.read<UserRepository>().createUser(jsonBody);
}
