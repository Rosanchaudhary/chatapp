part of 'chats_bloc.dart';

abstract class ChatsEvent extends Equatable {
  const ChatsEvent();

  @override
  List<Object> get props => [];
}

class CreateChat extends ChatsEvent {
  final User userB;
  const CreateChat({required this.userB});
}

class SetMyId extends ChatsEvent {
  final String myUserId;
  const SetMyId({required this.myUserId});
}

class GetMyChats extends ChatsEvent {}
