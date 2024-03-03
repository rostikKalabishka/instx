part of 'auth_bloc.dart';

enum UserAuthStatus { auth, unknown, unauth }

class AuthState extends Equatable {
  const AuthState({this.error = '', this.status = UserAuthStatus.unknown});
  final Object error;
  final UserAuthStatus status;

  @override
  List<Object> get props => [error, status];

  AuthState copyWith({Object? error, UserAuthStatus? status}) {
    return AuthState(error: error ?? this.error, status: status ?? this.status);
  }
}
