// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String detail;
  final String groupId;
  final String sendby;
  const Message({
    required this.detail,
    required this.groupId,
    required this.sendby,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        detail: json['message'],
        groupId: json['userAname'],
        sendby: json['userBname']);
  }

  @override
  List<Object?> get props => [detail, groupId, sendby];
}
