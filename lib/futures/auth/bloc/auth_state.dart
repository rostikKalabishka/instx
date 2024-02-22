// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState({this.error = ''});
  final Object error;

  @override
  List<Object> get props => [error];

  AuthState copyWith({
    Object? error,
  }) {
    return AuthState(
      error: error ?? this.error,
    );
  }
}
