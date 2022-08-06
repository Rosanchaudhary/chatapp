import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String discussionId;
  final String detail;
  final String groupId;
  final String sendby;
  final String sender;
  final String receiver;

  const Message(
      {required this.discussionId,
      required this.detail,
      required this.groupId,
      required this.sendby,
      required this.sender,
      required this.receiver});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        discussionId: json['discussionId'],
        detail: json['message'],
        groupId: json['userAname'],
        sendby: json['userBname'],
        sender: json['sender'],
        receiver: json['receiver']);
  }

  @override
  List<Object?> get props =>
      [discussionId, detail, groupId, sendby, sender, receiver];
}
