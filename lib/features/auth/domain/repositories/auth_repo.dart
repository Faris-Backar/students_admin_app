import 'package:dartz/dartz.dart';
import 'package:student_app_admin/core/app_core.dart';
import 'package:student_app_admin/features/auth/domain/entities/auth_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthEntity>> signInWithEmail(
      String email, String password);
  // Future<Either<Failure, Unit>> retrieveAdminProfile();
  Future<Either<Failure, Unit>> signOut();
}
