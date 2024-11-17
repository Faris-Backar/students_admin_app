part of 'auth_notifiers.dart';

class AuthState {
  final String? email;
  final bool isLoggedIn;
  final bool isLoading;

  const AuthState(
      {this.email, this.isLoggedIn = false, this.isLoading = false});

  factory AuthState.initial() {
    return const AuthState(email: null, isLoggedIn: false, isLoading: false);
  }

  factory AuthState.loading() {
    return const AuthState(isLoading: true);
  }
  factory AuthState.loggedIn(String email) {
    return AuthState(email: email, isLoggedIn: true, isLoading: false);
  }
  factory AuthState.error(String email) {
    return AuthState(email: email, isLoggedIn: false);
  }
}
