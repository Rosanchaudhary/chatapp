import 'package:chatapp/blocs/user/user_bloc.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chats"),
      ),

      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (BuildContext context, int index) {
                return Text(state.users[index].name);
              });
        },
      ),
    );
  }
}
