import 'package:dartz/dartz.dart';
import 'package:student_app_admin/core/app_core.dart';
import 'package:student_app_admin/features/students/domain/model/students_entity.dart';

abstract class StudentRepository {
  Future<Either<Failure, List<StudentEntity>>> getStudentsData();
}
