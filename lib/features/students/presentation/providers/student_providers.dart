import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_app_admin/features/auth/presentation/providers/auth_providers.dart';
import 'package:student_app_admin/features/students/data/repository/student_repository_impl.dart';

import 'package:student_app_admin/features/students/presentation/providers/student_notifiers.dart';
import 'package:student_app_admin/features/students/presentation/providers/student_state.dart';

final studenRepositoryProvider = Provider.autoDispose((ref) =>
    StudentRepositoryImpl(
        firebaseFirestore: ref.read(firebaseFirestoreProvider)));

final studentProvider =
    StateNotifierProvider<StudentNotifier, StudentState>((ref) {
  return StudentNotifier(studentRepository: ref.read(studenRepositoryProvider));
});
