import 'package:postgres/postgres.dart';
import 'package:riverpod/riverpod.dart';

/// Database Service for postgres
final databaseProvider = Provider<PostgreSQLConnection>((ref) {
  final postgreSQLConnection = PostgreSQLConnection(
    'localhost',
    5432,
    'authentication',
    username: 'postgres',
    password: 'example',
  );
  return postgreSQLConnection;
});

/// Sdasdasd
final ProviderContainer ref = ProviderContainer();
