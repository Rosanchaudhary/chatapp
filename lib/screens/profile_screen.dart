import 'package:chatapp/widgets/container_button.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const SettingScreen()));
              },
              icon: const Icon(
                Icons.settings_outlined,
                color: Colors.black,
              ))
        ],
      ),
      body: ListView(
        children: [
          Stack(children: [
            const Center(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 52.0,
                child: CircleAvatar(
                  radius: 50,
                  // backgroundImage: AssetImage(
                  //   'assets/ironmanhead.png',
                  // ),
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.55,
              top: 70,
              child: Container(
                  height: 34,
                  width: 34,
                  padding: const EdgeInsets.all(4), // Border width
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: const CircleAvatar(
                    child: Icon(
                      Icons.edit,
                      size: 16,
                    ),
                  )),
            )
          ]),
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text("Full Name"),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Tony Stark',
                  prefixIcon: Icon(CupertinoIcons.person),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18)))),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text("Username/Handle"),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'tonystark',
                  prefixIcon: Icon(CupertinoIcons.person),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18)))),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text("Email"),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'starktony@gmail.com',
                  prefixIcon: Icon(CupertinoIcons.person),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18)))),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text("Custom Link"),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Tony Stark',
                  suffixIcon: Icon(Icons.copy),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18)))),
            ),
          ),
          const ContainerButton(name: "Save")
        ],
      ),
    );
  }
}
