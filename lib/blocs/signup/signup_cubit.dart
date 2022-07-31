// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:chatapp/models/custom_error.dart';
import 'package:chatapp/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository authRepository;
  SignupCubit({required this.authRepository}) : super(SignupState.initial());

  Future<void> signup({
    required name,
    required email, 
    required password,
  }) async {
    emit(state.copyWith(signupStatus: SignupStatus.submitting));
    try {
      await authRepository.signUp(name: name, email: email, password: password);
      emit(state.copyWith(signupStatus: SignupStatus.success));
    } on CustomError catch (e) {
      emit(state.copyWith(signupStatus: SignupStatus.error, error: e));
    }
  }
}