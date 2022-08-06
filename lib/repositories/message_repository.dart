import 'package:chatapp/models/message_model.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

class MessageRepository {
  final FirebaseFirestore firebaseFirestore;
  MessageRepository({
    required this.firebaseFirestore,
  });
  Stream<List<Message>> getAllMessage({required String chatId}) {
    return firebaseFirestore
        .collection("messages")
        .where("discussionId", isEqualTo: chatId)
        .orderBy('createdAt',descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Message.fromJson(doc.data())).toList();
    });
  }

  createChat({required User userB, required fbAuth.User userA}) async {
    final userAMap = {
      "id": userA.uid,
      "name": userA.displayName,
      "imageUrl": userA.photoURL,
    };
    final userBMap = {
      "id": userB.id,
      "name": userB.name,
      "imageUrl": userB.profileUrl,
    };
    await firebaseFirestore.collection("chats").doc().set({
      "userA": userAMap,
      "userB": userBMap,
      "users": [userA.uid, userB.id]
    });
  }

  sendMessage(
      {required String discussionId,
      required String message,
      required String? userAname,
      required String userBname,
      required String userAId,
      required String userBId}) async {
    await firebaseFirestore.collection("messages").doc().set({
      "discussionId": discussionId,
      "message": message,
      "userAname": userAname,
      "userBname": userBname,
      "sender": userAId,
      "receiver": userBId,
      "users": [userAId, userBId],
      "createdAt": Timestamp.now()
    });
  }
}
