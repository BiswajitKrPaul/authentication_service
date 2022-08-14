import 'package:authentication_servicee/services/db_service.dart';
import 'package:dart_frog/dart_frog.dart';

/// Database Handler
Middleware databaseHandler() {
  return (handler) {
    return (context) async {
      final connection = ref.read(databaseProvider);
      if (connection.isClosed) {
        await ref.read(databaseProvider).open();
      }
      return handler(context);
    };
  };
}
