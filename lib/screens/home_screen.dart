import 'package:chatapp/blocs/chats/chats_bloc.dart';
import 'package:chatapp/blocs/user/user_bloc.dart';
import 'package:chatapp/screens/message_screen.dart';
import 'package:chatapp/widgets/chat_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetAllUser());
    context.read<ChatsBloc>().add(GetMyChats());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chats"),
      ),
      body: BlocBuilder<ChatsBloc, ChatsState>(
        builder: (context, state) {

          return ListView.builder(
              itemCount: state.chats.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MessageScreen(
                                  otherUser: state.myUserId == state.chats[index].userA.id ? state.chats[index].userB :state.chats[index].userA,
                                  chatId: state.chats[index].id,
                                )));
                  },
                  child: ChatBoxWidget(
                    user:state.myUserId == state.chats[index].userA.id ? state.chats[index].userB :state.chats[index].userA,
                  ),
                );
              });
        },
      ),
    );
  }
}
