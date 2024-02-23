import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'forget_password_event.dart';
part 'forget_password_state.dart';

class ForgetPasswordBloc extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  ForgetPasswordBloc() : super(ForgetPasswordInitial()) {
    on<ForgetPasswordEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
