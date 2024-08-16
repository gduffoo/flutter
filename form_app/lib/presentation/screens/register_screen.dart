import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_app/presentation/blocs/register/register_cubit.dart';
import 'package:form_app/presentation/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Nuevo Usuario"),
        ),
        body: BlocProvider(
          create: (context) => RegisterCubit(),
          child: const _Registerview(),
        ));
  }
}

class _Registerview extends StatelessWidget {
  const _Registerview();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FlutterLogo(),
              SizedBox(
                height: 15,
              ),
              _RegisterForm(),
              SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm();

  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final registerCubit = context.watch<RegisterCubit>();
    final username = registerCubit.state.username;
    final password = registerCubit.state.password;
    final email = registerCubit.state.email;

    return Form(
      //key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            label: "Usuario",
            onChanged: registerCubit.usernameChanged,
            errorText: username.errorMessage,
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextFormField(
            label: "Correo",
            onChanged: registerCubit.emailchanged,
            errorText: email.errorMessage,
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextFormField(
            label: "Password",
            obscureText: true,
            onChanged: registerCubit.passwordChanged,
            errorText: password.errorMessage,
          ),
          const SizedBox(
            height: 15,
          ),
          FilledButton.tonalIcon(
            onPressed: () {
              //final isValid = _formKey.currentState!.validate();
              //if (!isValid) return;
              registerCubit.onSubmit();
            },
            icon: const Icon(Icons.save),
            label: const Text("Grabar Usuario"),
          )
        ],
      ),
    );
  }
}
