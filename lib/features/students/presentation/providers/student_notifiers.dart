import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_app_admin/features/students/domain/repository/student_repository.dart';
import 'package:student_app_admin/features/students/presentation/providers/student_state.dart';

class StudentNotifier extends StateNotifier<StudentState> {
  final StudentRepository studentRepository;

  StudentNotifier({required this.studentRepository})
      : super(const StudentState.initial());

  Future<void> fetchStudents() async {
    state = const StudentState.loading();

    final result = await studentRepository.getStudentsData();

    result.fold((failure) {
      state = StudentState.error(failure.message);
      log("", error: failure.message);
    }, (students) {
      state = StudentState.loaded(students);
      log("Students Data => \n $students");
    });
  }
}
