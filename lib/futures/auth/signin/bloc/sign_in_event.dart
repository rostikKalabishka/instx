part of 'sign_in_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class NavigateToForgetPasswordPageEvent extends SignInEvent {
  final BuildContext context;

  const NavigateToForgetPasswordPageEvent({required this.context});

  @override
  List<Object> get props => super.props..addAll([context]);
}
