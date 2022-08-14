import 'dart:async';

import 'package:authentication_servicee/repository/user_repo.dart';
import 'package:dart_frog/dart_frog.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  final users = await context.read<UserRepository>().getAllUser();
  return Response.json(body: users);
}
