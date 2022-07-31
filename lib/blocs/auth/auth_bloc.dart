import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:chatapp/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

// ignore: library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final StreamSubscription authSubscription;
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(AuthState.unknown()) {
    authSubscription = authRepository.user.listen((fbAuth.User? user) {
      add(AuthStateChangedEvent(user: user));
    });
    on<AuthStateChangedEvent>((event, emit) { 
      if (event.user != null) { 
        emit(state.copyWith(
            authStatus: AuthStatus.authenticated, user: event.user));
      } else { 
        emit(
            state.copyWith(authStatus: AuthStatus.unauthenticated, user: null));
      }
    });
    on<SignOutRequestedEvent>((event, emit) async { 
      await authRepository.signOut();
    });
  }
  @override
  Future<void> close() {
    authSubscription.cancel();
    return super.close();
  }
}