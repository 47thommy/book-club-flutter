import 'package:client/application/login/login.dart';
import 'package:client/domain/auth/dto/login_form_dto.dart';
import 'package:client/domain/core/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:client/application/auth/auth_bloc.dart';
import 'package:client/application/auth/auth_event.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();
    final authBloc = context.read<AuthenticationBloc>();

    return Center(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Expanded(
                                child: Text(
                                  "Get ready to rewire you brain!",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(child: Image.asset("assets/books.png")),
                            ],
                          ),
                          const Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                                labelText: 'Email Address'),
                            validator: (value) {
                              var result = validateEmail(value!);

                              if (result != null) {
                                return result.failure!.message;
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: passwordController,
                            decoration:
                                const InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            validator: (value) {
                              var result = validatePassword(value!);

                              if (result != null) {
                                return result.failure!.message;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                          BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                            if (state is LoginLoading) {
                              return CircularProgressIndicator(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              );
                            } else {
                              return ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    var form = LoginFormDto(
                                        email: emailController.text,
                                        password: passwordController.text);

                                    loginBloc.add(LoginRequested(form));
                                  }
                                },
                                child: const Text('Login'),
                              );
                            }
                          }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Do not have an account?"),
                              TextButton(
                                onPressed: () =>
                                    authBloc.add(SignupPageRequested()),
                                child: const Text('Sign Up'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
