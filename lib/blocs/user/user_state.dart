// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

enum UserStatus { inital, loading, loaded, error }

class UserState extends Equatable {
  final List<User> users;
  final UserStatus userStatus;
  final CustomError error;
  const UserState(
      {required this.users, required this.userStatus, required this.error});

  factory UserState.inital() {
    return const UserState(
        users: <User>[], userStatus: UserStatus.inital, error: CustomError());
  }

  @override
  List<Object> get props => [users,userStatus,error];

  UserState copyWith({
    List<User>? users,
    UserStatus? userStatus,
    CustomError? error,
  }) {
    return UserState(
      users:users ?? this.users,
      userStatus:userStatus ?? this.userStatus,
      error:error ?? this.error,
    );
  }

  @override
  bool get stringify => true;
}
