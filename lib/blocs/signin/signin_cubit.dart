// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:chatapp/models/custom_error.dart';
import 'package:chatapp/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  final AuthRepository authRepository; 
  SigninCubit({required this.authRepository}) : super(SigninState.initial());

  Future<void> signin({required String email, required String password}) async {
    emit(state.copyWith(signinStatus: SigninStatus.submitting));
    try {
      await authRepository.signIn(email: email, password: password);
      emit(state.copyWith(signinStatus: SigninStatus.success));
    } on CustomError catch (e) {
      emit(state.copyWith(signinStatus: SigninStatus.error, error: e));
    }
  }
}