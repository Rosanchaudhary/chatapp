import 'package:chatapp/models/user_model.dart';
import 'package:flutter/material.dart';

class ChatBoxWidget extends StatelessWidget {
  final User user;
  const ChatBoxWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://randomuser.me/api/portraits/men/5.jpg"),
                  maxRadius: 30,
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          user.name,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          "rescent message",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                              fontWeight: true
                                  ? FontWeight.bold
                                  // ignore: dead_code
                                  : FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Text(
            '20:02',
            style: TextStyle(
                fontSize: 12,
                fontWeight:
                    // ignore: dead_code
                    true ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
