// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String profileUrl;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.profileUrl,
  });

  factory User.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return User(
        id: json.id,
        name: json.data()['name'], 
        email: json.data()['email'],
        profileUrl: json.data()['profileImage']);
  }

    factory User.fromChats(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        email: "email@gmail.com",
        profileUrl: json['imageUrl']);
  }

  @override
  List<Object?> get props => [id, name, email, profileUrl];
}
