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

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.watch<RegisterCubit>();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            label: "Usuario",
            onChanged: (value) {
              registerCubit.usernameChanged(value);
              _formKey.currentState?.validate();
            },
            validator: (value) {
              if (value == null || value.isEmpty) return 'Valor Requerido';
              if (value.trim().isEmpty) return 'Valor Requerido';
              if (value.length < 6) return 'mas de 6 caracteres';
              return null;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextFormField(
            label: "Correo",
            validator: (value) {
              if (value == null || value.isEmpty) return 'Valor Requerido';
              if (value.trim().isEmpty) return 'Valor Requerido';
              if (value.length < 6) return 'mas de 6 caracteres';
              final emailRegExp = RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              );
              if (!emailRegExp.hasMatch(value)) {
                return "no tiene formato de correo";
              }
              return null;
            },
            onChanged: (value) {
              registerCubit.emailchanged(value);
              _formKey.currentState?.validate();
            },
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextFormField(
            label: "Password",
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Valor Requerido';
              if (value.trim().isEmpty) return 'Valor Requerido';
              if (value.length < 6) return 'mas de 6 caracteres';
              return null;
            },
            onChanged: (value) {
              registerCubit.passwordChanged(value);
              _formKey.currentState?.validate();
            },
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
