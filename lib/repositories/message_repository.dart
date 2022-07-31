import 'package:chatapp/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageRepository {
  final FirebaseFirestore firebaseFirestore;
  MessageRepository({
    required this.firebaseFirestore,
  });
  Stream<List<Message>> getAllMessage() {
    return firebaseFirestore.collection("messages").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Message.fromJson(doc.data())).toList();
    });
  }
}
