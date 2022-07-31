import 'package:chatapp/blocs/auth/auth_bloc.dart';
import 'package:chatapp/blocs/message/message_bloc.dart';
import 'package:chatapp/blocs/signin/signin_cubit.dart';
import 'package:chatapp/blocs/signup/signup_cubit.dart';
import 'package:chatapp/blocs/user/user_bloc.dart';
import 'package:chatapp/repositories/auth_repository.dart';
import 'package:chatapp/repositories/message_repository.dart';
import 'package:chatapp/repositories/users_repository.dart';
import 'package:chatapp/screens/home_screen.dart';
import 'package:chatapp/screens/signin_screen.dart';
import 'package:chatapp/screens/signup_screen.dart';
import 'package:chatapp/screens/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
            create: (context) => AuthRepository(
                firebaseFirestore: FirebaseFirestore.instance,
                firebaseAuth: FirebaseAuth.instance)),
        RepositoryProvider<UserRepository>(
            create: (context) => UserRepository(
                  firebaseFirestore: FirebaseFirestore.instance,
                )),
        RepositoryProvider<MessageRepository>(
            create: (context) => MessageRepository(
                  firebaseFirestore: FirebaseFirestore.instance,
                )),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
              create: (context) =>
                  AuthBloc(authRepository: context.read<AuthRepository>())),
          BlocProvider<SigninCubit>(
              create: (context) =>
                  SigninCubit(authRepository: context.read<AuthRepository>())),
          BlocProvider<SignupCubit>(
              create: (context) =>
                  SignupCubit(authRepository: context.read<AuthRepository>())),
          BlocProvider<UserBloc>(
              create: (context) =>
                  UserBloc(userRepository: context.read<UserRepository>())),
          BlocProvider<MessageBloc>(
              create: (context) => MessageBloc(
                  messageRepository: context.read<MessageRepository>())),
        ],
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const SplashPage(),
            routes: {
              SignupPage.routeName: (context) => const SignupPage(),
              SigninPage.routeName: (context) => const SigninPage(),
              HomeScreen.routeName: (context) => const HomeScreen(),
            }),
      ),
    );
  }
}
