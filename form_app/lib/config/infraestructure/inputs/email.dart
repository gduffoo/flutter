import 'package:formz/formz.dart';

// Define input validation errors
enum EmaildError { empty, length, format }

// Extend FormzInput and provide the input type and error type.
class Email extends FormzInput<String, EmaildError> {
  // Call super.pure to represent an unmodified form input.
  const Email.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Email.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == EmaildError.empty) return "Campo requerido";
    if (displayError == EmaildError.length) return "Largo minimo 6";
    if (displayError == EmaildError.format) return "No tiene formato de correo";
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  EmaildError? validator(String value) {
    if (value.trim().isEmpty || value.isEmpty) return EmaildError.empty;
    if (value.length < 6) return EmaildError.length;

    final emailRegExp = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (!emailRegExp.hasMatch(value)) return EmaildError.format;

    return value.isEmpty ? EmaildError.empty : null;
  }
}
