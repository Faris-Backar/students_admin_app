import 'package:dartz/dartz.dart';
import 'package:student_app_admin/core/error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call({required Params params});
}
