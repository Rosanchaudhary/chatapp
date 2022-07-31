// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:chatapp/models/message_model.dart';
import 'package:chatapp/repositories/message_repository.dart';
import 'package:equatable/equatable.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository messageRepository;
  MessageBloc({required this.messageRepository}) : super(MessageInitial()) {
    on<GetAllMessage>((event, emit) async {
      await emit.onEach<List<Message>>(messageRepository.getAllMessage(),
          onData: (message) => add(MessageUpdated(message: message)));
    });
    on<MessageUpdated>((event, emit) {
      emit(MessageSuccess(message: event.message));
    });
  }
}
