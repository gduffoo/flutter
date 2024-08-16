import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_app/config/infraestructure/inputs/inputs.dart';
import 'package:formz/formz.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterFormState> {
  RegisterCubit() : super(const RegisterFormState());

  void onSubmit() {
    emit(
      state.copyWith(
          formstatus: FormStatus.validating,
          username: UserName.dirty(state.username.value),
          email: Email.dirty(state.email.value),
          password: Password.dirty(state.password.value),
          isValid: Formz.validate([
            state.username,
            state.password,
            state.email,
          ])),
    );
  }

  void usernameChanged(String value) {
    final userName = UserName.dirty(value);

    emit(state.copyWith(
      username: userName,
      isValid: Formz.validate([userName, state.password, state.email]),
    ));
  }

  void emailchanged(String value) {
    final email = Email.dirty(value);

    emit(state.copyWith(
      email: email,
      isValid: Formz.validate([email, state.password, state.username]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      isValid: Formz.validate([password, state.username, state.email]),
    ));
  }
}
