import 'package:authentication_servicee/repository/user_repo.dart';
import 'package:authentication_servicee/services/db_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/scaffolding.dart';

class _MockUserRespo extends Mock implements UserRepository {}

void main() {
  group('/v1/user/all', () {
    test('GET All User', () async {
      final container = ProviderContainer(
        overrides: [
          databaseProvider,
        ],
      );
      final connection = container.read(databaseProvider);
      await connection.open();
      final userRepo = _MockUserRespo();
      await userRepo.getAllUser();
    });
  });
}
