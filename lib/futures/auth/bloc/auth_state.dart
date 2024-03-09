part of 'auth_bloc.dart';

enum UserAuthStatus { auth, unknown, unauth }

enum ButtonStateStatus { noActive, process, success }

class AuthState extends Equatable {
  const AuthState(
      {this.error = '',
      this.status = UserAuthStatus.unknown,
      this.userId = ''});
  final Object error;
  final UserAuthStatus status;

  final String userId;

  @override
  List<Object> get props => [
        error,
        status,
        userId,
      ];

  AuthState copyWith({
    Object? error,
    UserAuthStatus? status,
    String? userId,
  }) {
    return AuthState(
      error: error ?? this.error,
      status: status ?? this.status,
      userId: userId ?? this.userId,
    );
  }
}
