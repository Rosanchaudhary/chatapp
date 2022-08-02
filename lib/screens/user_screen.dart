import 'package:chatapp/blocs/chats/chats_bloc.dart';
import 'package:chatapp/blocs/user/user_bloc.dart';
import 'package:chatapp/widgets/chat_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersScreen extends StatefulWidget {
  static const routeName = '/home';
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetAllUser());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Users"),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    context
                        .read<ChatsBloc>()
                        .add(CreateChat(userB: state.users[index]));
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => MessageScreen(userB: state.users[index],)));
                  },
                  child: ChatBoxWidget(
                    user: state.users[index],
                  ),
                );
              });
        },
      ),
    );
  }
}
