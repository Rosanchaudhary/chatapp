import 'package:chatapp/blocs/signup/signup_cubit.dart';
import 'package:chatapp/utils/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';

class SignupPage extends StatefulWidget {
  static const routeName = '/signup';
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _passwordController = TextEditingController();
  String? _name, _email, _password;

  void _submit() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    form.save();
    context
        .read<SignupCubit>()
        .signup(name: _name!, email: _email!, password: _password!);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state.signupStatus == SignupStatus.error) {
            errorDialog(context, state.error);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Form(
                    key: _formKey,
                    autovalidateMode: _autovalidateMode,
                    child: ListView(
                      shrinkWrap: true,
                      reverse: true,
                      children: [
                        Image.asset(
                          'assets/images/flutter_logo.png',
                          width: 250,
                          height: 250,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          autocorrect: false,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              filled: true,
                              labelText: 'Name',
                              prefixIcon: Icon(Icons.account_box)),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Name required';
                            }
                            if (value.trim().length < 2) {
                              return 'Name must be 2 character long';
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            _name = value;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              filled: true,
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email)),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Email required';
                            }
                            if (!isEmail(value.trim())) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            _email = value;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration:const  InputDecoration(
                              border: OutlineInputBorder(),
                              filled: true,
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock)),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Password required';
                            }
                            if (value.trim().length < 6) {
                              return 'Password must be 6 character long';
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            _password = value;
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              filled: true,
                              labelText: 'Confirm password',
                              prefixIcon: Icon(Icons.lock)),
                          validator: (String? value) {
                            if (_passwordController.text != value) {
                              return 'Passwords not match';
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            _password = value;
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        ElevatedButton(
                            onPressed:
                                state.signupStatus == SignupStatus.submitting
                                    ? null
                                    : _submit,
                            child: Text(
                              state.signupStatus == SignupStatus.submitting
                                  ? 'Loading..'
                                  : "Sign Up",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            )),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextButton(
                            onPressed:
                                state.signupStatus == SignupStatus.submitting
                                    ? null
                                    : () {
                                        Navigator.pop(context);
                                      },
                            child: const Text(
                              'Already a member',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  decoration: TextDecoration.underline),
                            ))
                      ].reversed.toList(),
                    )),
              ),
            ),
          );
        },
      ),
    );
  }
}