import 'package:formz/formz.dart';

// Define input validation errors
enum UserNameError { empty, length }

// Extend FormzInput and provide the input type and error type.
class UserName extends FormzInput<String, UserNameError> {
  // Call super.pure to represent an unmodified form input.
  const UserName.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const UserName.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == UserNameError.empty) return "Campo requerido";
    if (displayError == UserNameError.length) return "Largo minimo 6";
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  UserNameError? validator(String value) {
    if (value.trim().isEmpty || value.isEmpty) return UserNameError.empty;
    if (value.length < 6) return UserNameError.length;

    return value.isEmpty ? UserNameError.empty : null;
  }
}
