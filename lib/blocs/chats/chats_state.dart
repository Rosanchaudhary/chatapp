part of 'chats_bloc.dart';

enum ChatStatus { inital, loading, loaded, error }

class ChatsState extends Equatable {
  final String myUserId;
  final List<Chats> chats;
  final ChatStatus chatStatus;
  final CustomError error;
  const ChatsState(
      { required this.myUserId,required this.chats, required this.chatStatus, required this.error});

  factory ChatsState.inital() {
    return const ChatsState(
      myUserId: '',
        chats: <Chats>[], chatStatus: ChatStatus.inital, error: CustomError());
  }

  @override
  List<Object> get props => [myUserId,chats, chatStatus, error];

  ChatsState copyWith({
    String? myUserId,
    List<Chats>? chats,
    ChatStatus? chatStatus,
    CustomError? error,
  }) {
    return ChatsState(
      myUserId:myUserId??this.myUserId,
      chats: chats ?? this.chats,
      chatStatus: chatStatus ?? this.chatStatus,
      error: error ?? this.error,
    );
  }

  @override
  bool get stringify => true;
}
