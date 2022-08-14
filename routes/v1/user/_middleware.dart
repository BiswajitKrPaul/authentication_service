import 'package:authentication_servicee/repository/user_repo.dart';
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return handler.use(provider<UserRepository>((_) => UserRepository()));
}
