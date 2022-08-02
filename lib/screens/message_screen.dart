import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/widgets/send_message_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/message/message_bloc.dart';

class MessageScreen extends StatefulWidget {
  static const routeName = '/message';
  final String chatId;
  final User otherUser;
  const MessageScreen({Key? key, required this.chatId,required this.otherUser}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MessageBloc>().add(GetAllMessage(chatId: widget.chatId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.otherUser.name),
      ),
      body: ListView(children: [
        SizedBox(
          height: 400,
          child: BlocBuilder<MessageBloc, MessageState>(
            builder: (context, state) {
              return ListView.builder(
                  itemCount: state.message.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(state.message[index].detail);
                  });
            },
          ),
        ),
        SendMessageCard(
          discussionId: widget.chatId,
          otherUser: widget.otherUser,
        )
      ]),
    );
  }
}
