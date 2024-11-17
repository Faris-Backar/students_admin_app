import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:student_app_admin/features/students/domain/model/students_entity.dart';
part 'student_state.freezed.dart';

@freezed
class StudentState with _$StudentState {
  const factory StudentState.initial() = _Initial;
  const factory StudentState.loading() = _Loading;
  const factory StudentState.loaded(List<StudentEntity> students) = _Loaded;
  const factory StudentState.error(String message) = _Error;
}
