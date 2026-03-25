import 'package:equatable/equatable.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/model/auth_model.dart';

class AuthState extends Equatable {
  final bool isLoading;
  final bool validated;
  final bool requested;
  final String? error;
  final AuthModel? groups;

  const AuthState({
    required this.isLoading,
    required this.validated,
    this.error,
    this.groups,
    required this.requested,
  });

  factory AuthState.initial() {
    return const AuthState(
      isLoading: false,
      validated: false,
      requested: false,
    );
  }

  AuthState copyWith({
    bool? isLoading,
    bool? validated,
    bool? requested,
    String? error,
    AuthModel? groups,
    bool clearError = false,
    bool clearGroups = false,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      validated: validated ?? this.validated,
      requested: requested ?? this.requested,
      error: clearError ? null : (error ?? this.error),
      groups: clearGroups ? null : (groups ?? this.groups),
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    validated,
    requested,
    error,
    groups,
  ];
}
