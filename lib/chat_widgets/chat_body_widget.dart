import 'package:grad_project/screens/app/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/screens/app/profile_screen.dart';
import 'package:grad_project/screens/app/user_profile_screen.dart';

import '../models/chat_user.dart';

// ignore: must_be_immutable
class ChatBodyWidget extends StatelessWidget {
  final List<ChatUser> users;
  bool isDoctor;

  ChatBodyWidget({
    required this.users,
    required this.isDoctor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: buildChats()),
      );

  Widget buildChats() => ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final user = users[index];
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 75,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ChatPage(user: user, isDoctor: isDoctor),
                  ));
                },
                leading: const CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      'https://img.freepik.com/free-vector/cute-koala-with-cub-cartoon-icon-illustration_138676-2839.jpg?w=2000'),
                ),
                title: Text(user.name),
              ),
            ),
          );
        },
        itemCount: users.length,
      );
}
