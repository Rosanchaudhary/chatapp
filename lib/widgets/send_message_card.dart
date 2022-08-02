import 'package:chatapp/blocs/message/message_bloc.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendMessageCard extends StatefulWidget {
  const SendMessageCard({Key? key, required this.discussionId,required this.otherUser})
      : super(key: key);
  final String discussionId;
  final User otherUser;

  @override
  State<SendMessageCard> createState() => _SendMessageCardState();
}

class _SendMessageCardState extends State<SendMessageCard> {
  final TextEditingController _message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      height: 61,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35.0),
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 3), blurRadius: 5, color: Colors.grey)
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _message,
                      validator: (value) {
                        if (value!.isEmpty) return "Cannot be empty";
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.left,
                      decoration: const InputDecoration(
                          hintText: "Type Something...",
                          hintStyle: TextStyle(color: Colors.blueAccent),
                          border: InputBorder.none),
                    ),
                  ),
                  IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: Colors.blueAccent,
                      ),
                      onPressed: () {
                        context.read<MessageBloc>().add(SendMessage(
                          discussionId: widget.discussionId,
                            userB: widget.otherUser, message: _message.text));
                        FocusManager.instance.primaryFocus?.unfocus();
                        _message.clear();
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
