import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Screens {
  const Screens(this.label, this.icon, this.color);
  final String label;
  final IconData icon;
  final MaterialColor color;
}

const List<Screens> allScreens = <Screens>[
  Screens('Chats', Icons.chat, Colors.pink),
  Screens('People', CupertinoIcons.person, Colors.orange),
];