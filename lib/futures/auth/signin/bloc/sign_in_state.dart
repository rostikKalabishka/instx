part of 'sign_in_bloc.dart';

class SignInState extends Equatable {
  const SignInState({this.error = ''});
  final Object error;

  @override
  List<Object> get props => [error];

  SignInState copyWith({
    Object? error,
  }) {
    return SignInState(
      error: error ?? this.error,
    );
  }
}
