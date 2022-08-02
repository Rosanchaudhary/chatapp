import 'package:chatapp/models/user_model.dart';
import 'package:flutter/material.dart';

class ChatBoxWidget extends StatelessWidget {
  final User user;
  const ChatBoxWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        height: 60,
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(width: 1.5, color: Colors.grey.shade300),
        )),
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Image.network(
                  user.profileUrl,
                  height: 50,
                  width: 50,
                )),
            const SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name),
                const Text("Rescent message"),
              ],
            ),
          ],
        ));
  }
}
