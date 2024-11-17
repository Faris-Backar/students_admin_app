import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_app_admin/core/error/failure.dart';
import 'package:student_app_admin/features/auth/domain/entities/auth_entity.dart';
import 'package:student_app_admin/features/auth/domain/repositories/auth_repo.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  AuthRepositoryImpl(
      {required this.firebaseAuth, required this.firebaseFirestore});

  @override
  Future<Either<Failure, AuthEntity>> signInWithEmail(
      String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(AuthEntity(username: email, password: password));
    } on FirebaseAuthException catch (e) {
      return left(_mapFirebaseAuthExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    try {
      await firebaseAuth.signOut();
      return right(unit); // Unit represents void in dartz
    } catch (e) {
      return left(ServerFailure(message: "Sign out failed: ${e.toString()}"));
    }
  }

  /// Maps Firebase authentication exceptions to custom failure classes.
  Failure _mapFirebaseAuthExceptionToFailure(FirebaseAuthException e) {
    log("Firebase Auth Error => ${e.code}",
        name: 'FirebaseAuth'); // Optionally add a name to the log for clarity
    switch (e.code) {
      case 'invalid-email':
        return const InvalidEmailFailure();
      case 'user-not-found':
        return const UserNotFoundFailure();
      case 'wrong-password':
        return const WrongPasswordFailure();
      case 'user-disabled':
        return const UserDisabledFailure();
      case 'too-many-requests':
        return const TooManyRequestsFailure();
      case 'weak-password':
        return const WeakPasswordFailure();
      case 'invalid-credential':
        return const InvalidCredentialFailure();
      default:
        // Log additional context for unknown errors
        log('Unknown FirebaseAuthError: ${e.message}', name: 'FirebaseAuth');
        return ServerFailure(message: e.message ?? "Authentication failed");
    }
  }
}
