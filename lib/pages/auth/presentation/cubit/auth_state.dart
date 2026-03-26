import 'package:equatable/equatable.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/model/auth_group_model.dart';

class AuthState extends Equatable {
  final bool isLoading;
  final bool validated;
  final bool requested;
  final bool sessionChecked;
  final String? error;
  final AuthGroupModel? groups;

  const AuthState({
    required this.isLoading,
    required this.validated,
    required this.requested,
    required this.sessionChecked,
    this.error,
    this.groups,
  });

  factory AuthState.initial() {
    return const AuthState(
      isLoading: false,
      validated: false,
      requested: false,
      sessionChecked: false,
    );
  }

  AuthState copyWith({
    bool? isLoading,
    bool? validated,
    bool? requested,
    bool? sessionChecked,
    String? error,
    AuthGroupModel? groups,
    bool clearError = false,
    bool clearGroups = false,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      validated: validated ?? this.validated,
      requested: requested ?? this.requested,
      sessionChecked: sessionChecked ?? this.sessionChecked,
      error: clearError ? null : (error ?? this.error),
      groups: clearGroups ? null : (groups ?? this.groups),
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    validated,
    requested,
    sessionChecked,
    error,
    groups,
  ];
}
