part of 'signup_cubit.dart';

enum SignupStatus {
  intitial,
  submitting,
  success,
  error,
}

class SignupState extends Equatable {
  final SignupStatus signupStatus;
  final CustomError error;
  const SignupState({required this.signupStatus, required this.error});

  factory SignupState.initial() {
    return const SignupState(
        signupStatus: SignupStatus.intitial, error: CustomError());
  }

  @override
  List<Object> get props => [signupStatus, error];

  @override
  String toString() =>
      'SigninState(signupStatus: $signupStatus, error: $error)';

  SignupState copyWith({SignupStatus? signupStatus, CustomError? error}) {
    return SignupState(
        signupStatus: signupStatus ?? this.signupStatus,
        error: error ?? this.error);
  }
}