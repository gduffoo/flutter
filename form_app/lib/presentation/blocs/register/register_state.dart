part of 'register_cubit.dart';

enum FormStatus { invalid, valid, validating, posting }

class RegisterFormState extends Equatable {
  final FormStatus formstatus;
  final UserName username;
  final Email email;
  final Password password;
  final bool isValid;

  const RegisterFormState({
    this.formstatus = FormStatus.invalid,
    this.username = const UserName.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.isValid = false,
  });

  RegisterFormState copyWith({
    FormStatus? formstatus,
    UserName? username,
    Email? email,
    Password? password,
    bool? isValid,
  }) =>
      RegisterFormState(
        formstatus: formstatus ?? this.formstatus,
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
        isValid: isValid ?? this.isValid,
      );

  @override
  List<Object> get props => [formstatus, username, email, password];
}

final class RegisterInitial extends RegisterFormState {}
