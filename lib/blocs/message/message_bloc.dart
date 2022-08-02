// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chatapp/blocs/auth/auth_bloc.dart';
import 'package:chatapp/models/custom_error.dart';
import 'package:chatapp/models/message_model.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/repositories/auth_repository.dart';
import 'package:chatapp/repositories/message_repository.dart';
import 'package:equatable/equatable.dart';
// ignore: library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository messageRepository;
  final AuthRepository authRepository;
  final AuthBloc authBloc;
  late StreamSubscription authStream;

  late fbAuth.User? userA;

  MessageBloc(
      {required this.messageRepository,
      required this.authRepository,
      required this.authBloc})
      : super(MessageState.initial()) {
    authStream = authRepository.user.listen((fbAuth.User? user) {
      userA = user!;
    });
    userA = authBloc.state.user;

    on<GetAllMessage>((event, emit) async {
      await emit.onEach<List<Message>>( 
          messageRepository.getAllMessage(chatId: event.chatId),
          onData: (message) => add(MessageUpdated(message: message)));
    });
    on<MessageUpdated>((event, emit) {
      emit(state.copyWith(
          message: event.message, messageStatus: MessageStatus.loaded));
    });

    on<SendMessage>((event, emit) async {
      try {
        await messageRepository.sendMessage(
          discussionId:event.discussionId,
            message: event.message,
            userAname: userA!.displayName,
            userBname: event.userB.name,
            userAId: userA!.uid,
            userBId: event.userB.id);
      } on CustomError catch (e) {
        emit(state.copyWith(messageStatus: MessageStatus.error, error: e));
      }
    });
  }

  @override
  Future<void> close() {
    authStream.cancel();
    return super.close();
  }
}
