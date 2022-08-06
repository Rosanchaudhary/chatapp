import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/widgets/send_message_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/message/message_bloc.dart';

class MessageScreen extends StatefulWidget {
  static const routeName = '/message';
  final String chatId;
  final User otherUser;
  const MessageScreen({Key? key, required this.chatId, required this.otherUser})
      : super(key: key);

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
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://randomuser.me/api/portraits/men/5.jpg"),
                  maxRadius: 20,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.otherUser.name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.settings,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: BlocBuilder<MessageBloc, MessageState>(
            builder: (context, state) {
              return ListView.builder(
                  reverse: true,
                  itemCount: state.message.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.only(
                          left: 14, right: 14, top: 10, bottom: 10),
                      child: Align(
                        alignment:
                            widget.otherUser.id == state.message[index].receiver
                                ? Alignment.topRight
                                : Alignment.topLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (widget.otherUser.id ==
                                    state.message[index].receiver
                                ? Colors.blue[200]
                                : Colors.grey[200]),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            state.message[index].detail,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    );
                  });
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SendMessageCard(
            discussionId: widget.chatId,
            otherUser: widget.otherUser,
          ),
        )
      ]),
    );
  }
}
