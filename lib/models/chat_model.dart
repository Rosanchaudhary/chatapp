// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:chatapp/models/user_model.dart';

class Chats extends Equatable {
  final String id;
  final User userA;
  final User userB;
  const Chats({
    required this.id,
    required this.userA,
    required this.userB,
  });

  factory Chats.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return Chats(
        id: json.id,
        userA: User.fromChats(json.data()['userA']), 
        userB: User.fromChats(json.data()['userB']));
  }

  @override
  List<Object?> get props => [id, userA, userB];
}
