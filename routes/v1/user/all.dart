import 'package:authentication_servicee/repository/user_repo.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final result = await context.read<UserRepository>().getAllUser();
  return Response.json(body: result);
}
