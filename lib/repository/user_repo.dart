import 'dart:async';
import 'dart:io';

import 'package:authentication_servicee/prisma_client.dart';
import 'package:authentication_servicee/services/db_service.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:orm/orm.dart';

/// User Repository
class UserRepository {
  final db = ref.read(prismaClientProvider);

  /// Get All User
  FutureOr<Response> getAllUser({int page = 1, int limit = 50}) async {
    try {
      final users = await db.user.findMany(
        skip: page > 1 ? (page - 1) * limit : null,
        take: limit,
        orderBy: [const UserOrderByWithRelationInput(id: SortOrder.asc)],
      );
      return Response.json(body: users);
    } on PrismaClientKnownRequestError catch (e) {
      return Response.json(statusCode: HttpStatus.badRequest, body: e.message);
    } catch (e) {
      return Response.json(
        statusCode: HttpStatus.internalServerError,
        body: {'error': 'Server Not Responding'},
      );
    }
  }

  FutureOr<Response> login(Map<String, dynamic> body) async {
    try {
      final email = body['email'] as String?;
      final password = body['password'] as String?;
      if (email == null || email == '') {
        return Response(
          statusCode: HttpStatus.badRequest,
          body: 'Email is mandatory',
        );
      } else if (password == null || password == '') {
        return Response(
          statusCode: HttpStatus.badRequest,
          body: 'Password is mandatory',
        );
      } else {
        final user = await db.user.findUnique(
          where: UserWhereUniqueInput(email: email),
        );
        if (user != null) {
          if (BCrypt.checkpw(password, user.password)) {
            final jwt = JWT(
              {'id': user.id, 'email': user.email},
              issuer: 'in.haxon420',
            );
            final token = jwt.sign(SecretKey(env['jwtKey'] ?? ''));
            return Response.json(
              body: {'token': token},
            );
          } else {
            return Response(
              statusCode: HttpStatus.badRequest,
              body: 'Password not correct',
            );
          }
        }
        return Response(
          statusCode: HttpStatus.notFound,
          body: 'User not found',
        );
      }
    } on PrismaClientKnownRequestError catch (e) {
      return Response.json(statusCode: HttpStatus.badRequest, body: e.message);
    } catch (e) {
      return Response.json(
        statusCode: HttpStatus.internalServerError,
        body: {'error': 'Server Not Responding'},
      );
    }
  }

  Future<Response> createUser(Map<String, dynamic> jsonBody) async {
    try {
      await db.user.create(
        data: UserCreateInput(
          email: jsonBody['email'] as String,
          password:
              BCrypt.hashpw(jsonBody['password'] as String, BCrypt.gensalt()),
        ),
      );
      return Response(
        statusCode: HttpStatus.created,
        body: 'User Created',
      );
    } on PrismaClientKnownRequestError catch (e) {
      return Response.json(
        statusCode: HttpStatus.badRequest,
        body: {'error': e.message},
      );
    } catch (e) {
      return Response.json(
        statusCode: HttpStatus.badRequest,
        body: {'error': 'Server Not Responding'},
      );
    }
  }
}
