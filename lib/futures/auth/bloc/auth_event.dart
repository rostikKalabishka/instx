part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthWithGoogle extends AuthEvent {}

class AuthWithApple extends AuthEvent {}

class NavigateToRegistration extends AuthEvent {
  final BuildContext context;

  const NavigateToRegistration({required this.context});

  @override
  List<Object> get props => super.props..addAll([context]);
}

class NavigateToSignIn extends AuthEvent {
  final BuildContext context;

  const NavigateToSignIn({required this.context});

  @override
  List<Object> get props => super.props..addAll([context]);
}

class AuthenticationUserChanged extends AuthEvent {
  const AuthenticationUserChanged(
    this.user,
  );

  final User? user;
}
