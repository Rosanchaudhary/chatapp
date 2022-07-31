// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:chatapp/models/custom_error.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/repositories/users_repository.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserState.inital()) {
    on<GetAllUser>((event, emit) async {
      emit(state.copyWith(userStatus: UserStatus.loading));
      try {
        final users = await userRepository.getAllUsers();

        emit(state.copyWith(userStatus: UserStatus.loaded, users: users));
      }  on CustomError catch (e) {
        emit(state.copyWith(userStatus: UserStatus.error,error: e));
      }
    });
  }
}
