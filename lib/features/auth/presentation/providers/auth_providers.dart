import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_app_admin/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:student_app_admin/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:student_app_admin/features/auth/presentation/providers/auth_notifiers.dart';

final firebaseAuthProvider =
    Provider.autoDispose((ref) => FirebaseAuth.instance);

final firebaseFirestoreProvider =
    Provider.autoDispose((ref) => FirebaseFirestore.instance);

final authRepositoryProvider = Provider((ref) => AuthRepositoryImpl(
      firebaseAuth: ref.watch(firebaseAuthProvider),
      firebaseFirestore: ref.read(firebaseFirestoreProvider),
    ));

final signInUseCaseProvider = Provider(
  (ref) => SignInWithEmail(repository: ref.watch(authRepositoryProvider)),
);

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(signInWithEmail: ref.read(signInUseCaseProvider));
});
