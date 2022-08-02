// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chatapp/blocs/auth/auth_bloc.dart';
import 'package:chatapp/models/chat_model.dart';
import 'package:chatapp/models/custom_error.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/repositories/auth_repository.dart';
import 'package:chatapp/repositories/chat_repository.dart';
import 'package:chatapp/repositories/message_repository.dart';
import 'package:equatable/equatable.dart';
// ignore: library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

part 'chats_event.dart';
part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  final MessageRepository messageRepository;
  final AuthRepository authRepository;
  final ChatRepository chatRepository;
  final AuthBloc authBloc;
  late StreamSubscription authStream;

  late fbAuth.User? userA;
  ChatsBloc(
      {required this.messageRepository,
      required this.authRepository,
      required this.authBloc,
      required this.chatRepository})
      : super(ChatsState.inital()) {
    authStream = authRepository.user.listen((fbAuth.User? user) {
      userA = user!;
      add(SetMyId(myUserId: user.uid));
    });
    userA = authBloc.state.user;

    on<SetMyId>((event, emit) {
      emit(state.copyWith(myUserId: event.myUserId));
    });
    on<CreateChat>((event, emit) async {
      try {
        await messageRepository.createChat(
          userA: userA!,
          userB: event.userB,
        );
      } on CustomError catch (e) {
        emit(state.copyWith(chatStatus: ChatStatus.error, error: e));
      }
    });

    on<GetMyChats>((event, emit) async {
      emit(state.copyWith(chatStatus: ChatStatus.loading));
      try {
        final chats = await chatRepository.getMyChats(myUserId: userA!.uid);
        emit(state.copyWith(chats: chats, chatStatus: ChatStatus.loaded));
      } on CustomError catch (e) {
        emit(state.copyWith(chatStatus: ChatStatus.error, error: e));
      }
    });
  }
}
