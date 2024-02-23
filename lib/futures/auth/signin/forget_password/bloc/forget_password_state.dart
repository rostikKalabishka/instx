part of 'forget_password_bloc.dart';

sealed class ForgetPasswordState extends Equatable {
  const ForgetPasswordState();
  
  @override
  List<Object> get props => [];
}

final class ForgetPasswordInitial extends ForgetPasswordState {}
