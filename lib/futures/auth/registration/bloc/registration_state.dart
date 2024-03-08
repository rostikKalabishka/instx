part of 'registration_bloc.dart';

enum UserAuthStatus { process, success, failure }

class RegistrationState extends Equatable {
  const RegistrationState(
      {this.error = '', this.status = UserAuthStatus.process});
  final Object error;
  final UserAuthStatus status;
  RegistrationState copyWith({Object? error, UserAuthStatus? status}) {
    return RegistrationState(
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [error, status];
}
