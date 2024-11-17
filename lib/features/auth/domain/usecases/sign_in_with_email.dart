import 'package:dartz/dartz.dart';
import 'package:student_app_admin/core/app_core.dart';
import 'package:student_app_admin/core/params/signin_params.dart';
import 'package:student_app_admin/core/usecase/usecase.dart';
import 'package:student_app_admin/features/auth/domain/entities/auth_entity.dart';
import 'package:student_app_admin/features/auth/domain/repositories/auth_repo.dart';

class SignInWithEmail implements UseCase<AuthEntity, SignInParams> {
  final AuthRepository repository;
  SignInWithEmail({required this.repository});

  @override
  Future<Either<Failure, AuthEntity>> call({required SignInParams params}) {
    return repository.signInWithEmail(params.email, params.password);
  }
}
