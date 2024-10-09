import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_project/controllers/firebase_api.dart';
import 'package:grad_project/models/message.dart';
import 'package:grad_project/chat_widgets/message_widget.dart';
import 'package:flutter/material.dart';

import '../controllers/fb_auth_controller.dart';

class MessagesWidget extends StatelessWidget {
  final String id;
  User user = FbAuthController().user;
  bool isDoctor;

   MessagesWidget({
    required this.id,
    required this.isDoctor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder<List<Message>>(
        stream: FirebaseApi.getMessages(isDoctor,id),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return buildText('Something Went Wrong Try later');
              } else {
                final messages = snapshot.data;

                return messages!.isEmpty
                    ? buildText('Say Hi..')
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          print(message.toJson());
                          return MessageWidget(
                            message: message,
                            isMe: message.id == user.uid,
                          );
                        },
                      );
              }
          }
        },
      );

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style:const TextStyle(fontSize: 24),
        ),
      );
}
