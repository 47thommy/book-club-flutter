import 'package:client/application/auth/auth_bloc.dart';
import 'package:client/application/auth/auth_event.dart';
import 'package:client/application/signup/signup.dart';
import 'package:client/application/signup/signup_bloc.dart';
import 'package:client/application/signup/signup_event.dart';
import 'package:client/domain/auth/dto/registration_form_dto.dart';
import 'package:client/domain/core/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final signupBloc = context.read<SignupBloc>();
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          controller: firstNameController,
                          decoration:
                              const InputDecoration(labelText: 'First Name'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                          onSaved: (value) {},
                        ),
                        TextFormField(
                          controller: lastNameController,
                          decoration:
                              const InputDecoration(labelText: 'Last Name'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your last name';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration:
                              const InputDecoration(labelText: 'Email Address'),
                          validator: (value) {
                            var result = validateEmail(value!);

                            if (result != null) {
                              return result.failure!.message;
                            }
                            return null;
                          },
                          onSaved: (value) {},
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
                        BlocBuilder<SignupBloc, SignupState>(
                            builder: (context, state) {
                          if (state is SignupLoading) {
                            return CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.onBackground,
                            );
                          } else {
                            return ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();

                                  var form = RegisterFormDto(
                                      firstName: firstNameController.text,
                                      lastName: lastNameController.text,
                                      email: emailController.text,
                                      password: passwordController.text);

                                  signupBloc.add(SignupRequested(form));
                                }
                              },
                              child: const Text('Sign Up'),
                            );
                          }
                        }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                            ),
                            TextButton(
                              onPressed: () {
                                authBloc.add(LoginPageRequested());
                              },
                              child: const Text('Login'),
                            ),
                          ],
                        ),
                      ],
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
