// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'message_bloc.dart';

enum MessageStatus { initial, loading, loaded, error }

class MessageState extends Equatable {
  final MessageStatus messageStatus;
  final List<Message> message;
  final CustomError error;
  const MessageState(
      {required this.message,
      required this.messageStatus,
      required this.error});

  factory MessageState.initial() {
    return const MessageState(
        message: <Message>[],
        messageStatus: MessageStatus.initial,
        error: CustomError());
  }

  @override
  List<Object> get props => [message, messageStatus, error];

  MessageState copyWith({
    MessageStatus? messageStatus,
    List<Message>? message,
    CustomError? error,
  }) {
    return MessageState(
      messageStatus: messageStatus ?? this.messageStatus,
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }

  @override
  String toString() =>
      'MessageState(messageStatus: $messageStatus, error: $error,message:$message)';
}

// class MessageInitial extends MessageState {}

// class MessageSuccess extends MessageState {
//   const MessageSuccess({required this.message});
//   final List<Message> message;

//   @override
//   List<Object> get props => [message];
// }
