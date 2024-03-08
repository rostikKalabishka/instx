part of 'registration_bloc.dart';

class RegistrationEvent extends Equatable {
  const RegistrationEvent(
      {required this.email,
      required this.password,
      required this.userName,
      required this.context});
  final String email;
  final String password;
  final String userName;
  final BuildContext context;

  @override
  List<Object> get props => [email, password, userName, context];
}
