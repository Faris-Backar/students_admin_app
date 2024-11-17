import 'package:dartz/dartz.dart';
import 'package:student_app_admin/core/app_core.dart';
import 'package:student_app_admin/core/params/no_params.dart';
import 'package:student_app_admin/core/usecase/usecase.dart';
import 'package:student_app_admin/features/students/domain/model/students_entity.dart';
import 'package:student_app_admin/features/students/domain/repository/student_repository.dart';

class GetStudentsData implements UseCase<List<StudentEntity>, NoParams> {
  final StudentRepository repository;
  GetStudentsData({required this.repository});

  @override
  Future<Either<Failure, List<StudentEntity>>> call(
      {required NoParams params}) {
    return repository.getStudentsData();
  }
}
