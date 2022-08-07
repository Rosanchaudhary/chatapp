import 'package:flutter/material.dart';

class ContainerButton extends StatelessWidget {
  final String name;
  const ContainerButton({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 52,
        decoration: const BoxDecoration(
            color:  Color.fromRGBO(34, 129, 227, 1),
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Center(
          child: Text(
            name,
            style:const TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}