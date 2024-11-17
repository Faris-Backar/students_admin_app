import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_app_admin/core/di/shared_preference_manager.dart';
import 'package:student_app_admin/core/params/signin_params.dart';
import 'package:student_app_admin/core/resources/shared_prefs_resources.dart';
import 'package:student_app_admin/features/auth/domain/usecases/sign_in_with_email.dart';
part "auth_state.dart";

class AuthNotifier extends StateNotifier<AuthState> {
  final SignInWithEmail signInWithEmail;
  AuthNotifier({required this.signInWithEmail}) : super(AuthState.initial());

  void signIn(String email, String password) async {
    state = AuthState.loading();
    final result = await signInWithEmail(
        params: SignInParams(email: email, password: password));
    result.fold((failure) => state = AuthState.error(failure.message),
        (user) async {
      await SharedPrefManager.setBool(SharedPrefsResources.isLoggedin, true);
      state = AuthState.loggedIn(email);
      log("auth success");
    });
  }
}
