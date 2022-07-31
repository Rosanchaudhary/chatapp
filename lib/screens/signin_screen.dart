import 'package:chatapp/blocs/signin/signin_cubit.dart';
import 'package:chatapp/screens/signup_screen.dart';
import 'package:chatapp/utils/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';

class SigninPage extends StatefulWidget {
  static const routeName = '/signin';
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? _email, _password;

  void _submit() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    form.save();
    context.read<SigninCubit>().signin(email: _email!, password: _password!);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<SigninCubit, SigninState>(
          listener: (context, state) {
            if (state.signinStatus == SigninStatus.error) {
              errorDialog(context,state.error);
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
                        children: [

                          const SizedBox(
                            height: 20.0,
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
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            decoration: const InputDecoration(
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
                          ElevatedButton(
                              onPressed: state.signinStatus == SigninStatus.submitting ? null : _submit,
                              child: Text(
                                state.signinStatus == SigninStatus.submitting ? 'Loading..' :
                                "Sign In",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20.0),
                              )),
                          const SizedBox(
                            height: 10.0,
                          ),
                          TextButton(
                              onPressed:state.signinStatus == SigninStatus.submitting ? null : () {
                                Navigator.pushNamed(
                                    context, SignupPage.routeName);
                              },
                              child: const Text(
                                'Not a member ? Sign UP',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    decoration: TextDecoration.underline),
                              ))
                        ],
                      )),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}