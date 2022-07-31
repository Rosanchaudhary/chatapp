import 'package:chatapp/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final FirebaseFirestore firebaseFirestore;
  UserRepository({
    required this.firebaseFirestore,
  });
  Future<List<User>> getAllUsers() async {
    final response = await firebaseFirestore.collection("users").get();
    final users = response.docs.map((doc) => User.fromJson(doc)).toList();
    return users;
  }
}
