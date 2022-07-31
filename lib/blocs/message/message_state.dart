part of 'message_bloc.dart';

abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

class MessageInitial extends MessageState {}

class MessageSuccess extends MessageState {
  const MessageSuccess({required this.message});
  final List<Message> message;

  @override
  List<Object> get props => [message];
}
