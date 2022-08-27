import 'package:postgres/postgres.dart';
import 'package:riverpod/riverpod.dart';

/// Database Service for postgres
final databaseProvider = Provider<PostgreSQLConnection>((ref) {
  final postgreSQLConnection = PostgreSQLConnection(
    'localhost',
    5432,
    'authentication_service',
    username: 'postgres',
    password: 'postgres',
  );
  return postgreSQLConnection;
});

/// Sdasdasd
final ProviderContainer ref = ProviderContainer();
