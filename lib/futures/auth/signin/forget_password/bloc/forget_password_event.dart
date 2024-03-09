part of 'forget_password_bloc.dart';

class ForgetPasswordEvent extends Equatable {
  const ForgetPasswordEvent(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}
