class AuthState {
  final bool? isLoading;
  final String? error;
  final bool? isLogged;
  final bool? isRegister;
  final bool? resetPassword;

  AuthState({
    this.isLoading,
    this.error,
    this.isLogged,
    this.isRegister,
    this.resetPassword,
  });

  AuthState copyWith({
    final bool? isLoading,
    final String? error,
    final bool? isLogged,
    final bool? isRegister,
    final bool? resetPassword,
  }) {
    return AuthState(
      resetPassword: resetPassword,
      isLoading: isLoading,
      error: error,
      isLogged: isLogged,
      isRegister: isRegister,
    );
  }
}
