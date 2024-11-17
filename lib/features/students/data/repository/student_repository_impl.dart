import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:student_app_admin/core/error/failure.dart';
import 'package:student_app_admin/core/resources/firebase_resources.dart';
import 'package:student_app_admin/features/students/data/model/student.dart';
import 'package:student_app_admin/features/students/domain/model/students_entity.dart';
import 'package:student_app_admin/features/students/domain/repository/student_repository.dart';

class StudentRepositoryImpl extends StudentRepository {
  final FirebaseFirestore firebaseFirestore;

  StudentRepositoryImpl({required this.firebaseFirestore});

  @override
  Future<Either<Failure, List<StudentEntity>>> getStudentsData() async {
    try {
      final querySnapshot =
          await firebaseFirestore.collection(FirebaseReources.users).get();
      final students =
          querySnapshot.docs.map((doc) => Student.fromFirestore(doc)).toList();
      return right(students);
    } on FirebaseException catch (e) {
      log(
        "error from firebase => ${e.code}",
        error: e.message,
      );
      return left(ServerFailure(
          message: "Failed to fetch student data: ${e.toString()}"));
    }
  }
}
