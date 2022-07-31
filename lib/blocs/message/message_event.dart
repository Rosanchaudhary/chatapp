part of 'message_bloc.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class GetAllMessage extends MessageEvent {}

class MessageUpdated extends MessageEvent {
  const MessageUpdated({required this.message});

  final List<Message> message;

  @override
  List<Object> get props => [message];
}
