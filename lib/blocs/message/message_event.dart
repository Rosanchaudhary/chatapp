part of 'message_bloc.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class GetAllMessage extends MessageEvent { 
  final String chatId;
  const GetAllMessage({required this.chatId});
}

class MessageUpdated extends MessageEvent {
  const MessageUpdated({required this.message});

  final List<Message> message;

  @override
  List<Object> get props => [message];
}

class SendMessage extends MessageEvent {
  final String discussionId;
  final String message;
  final User userB;
  const SendMessage(
      {required this.userB, required this.message, required this.discussionId});
}
