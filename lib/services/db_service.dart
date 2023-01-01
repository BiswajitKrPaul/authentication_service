import 'package:authentication_servicee/prisma_client.dart';
import 'package:dotenv/dotenv.dart';
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

final prismaClientProvider = Provider<PrismaClient>((ref) {
  return PrismaClient();
});

/// Sdasdasd
final ProviderContainer ref = ProviderContainer();

final env = DotEnv()..load();
