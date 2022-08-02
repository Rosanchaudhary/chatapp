import 'package:chatapp/models/chat_model.dart';
import 'package:chatapp/models/custom_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRepository {
  final FirebaseFirestore firebaseFirestore;
  const ChatRepository({required this.firebaseFirestore});

  Future<List<Chats>> getMyChats({required String myUserId}) async {
    try {
      final response = await firebaseFirestore.collection("chats").where('users',arrayContains: myUserId).get();
      final chats = response.docs.map((doc) => Chats.fromJson(doc)).toList();
      return chats;
    } catch (e) {
      throw CustomError(
          code: 'Exception',
          message: e.toString(),
          plugin: 'flutter_error/server_error');
    }
  }
}
