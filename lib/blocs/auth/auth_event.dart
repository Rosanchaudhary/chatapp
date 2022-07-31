part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}
 
class AuthStateChangedEvent extends AuthEvent {
  final fbAuth.User? user; 
  const AuthStateChangedEvent({this.user});

  @override
  List<Object?> get props => [user];
}

class SignOutRequestedEvent extends AuthEvent {}