import 'package:authentication_servicee/services/db_service.dart';
import 'package:orm/configure.dart';

/// Configure Prisma for production environment.
///
/// **NOTE**: The function name must be configurePrisma.
void configurePrisma(PrismaEnvironment environment) {
  environment['DATABASE_URL'] = env['DATABASE_URL'] ?? '';
}
