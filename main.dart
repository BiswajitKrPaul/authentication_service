import 'dart:io';

import 'package:authentication_servicee/services/db_service.dart';
import 'package:dart_frog/dart_frog.dart';

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) async {
  final connection = ref.read(databaseProvider);
  if (connection.isClosed) {
    await ref.read(databaseProvider).open();
  }
  return serve(handler, ip, 9090);
}
