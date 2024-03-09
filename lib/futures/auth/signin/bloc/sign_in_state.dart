part of 'sign_in_bloc.dart';

class SignInState extends Equatable {
  const SignInState({this.error = '', this.status = UserAuthStatus.unknown});
  final Object error;
  final UserAuthStatus status;

  @override
  List<Object> get props => [error, status];

  SignInState copyWith({
    Object? error,
    UserAuthStatus? status,
  }) {
    return SignInState(
        error: error ?? this.error, status: status ?? this.status);
  }
}
