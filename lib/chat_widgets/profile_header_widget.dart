import 'package:flutter/material.dart';
import 'package:grad_project/models/chat_user.dart';
import 'package:grad_project/screens/app/user_profile_screen.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final ChatUser user;
  final bool isDoctor;

  const ProfileHeaderWidget({
    required this.user,
    required this.isDoctor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        height: 80,
        padding: const EdgeInsets.all(16).copyWith(left: 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const BackButton(color: Colors.white),
                TextButton(
                  onPressed: () {
                    if (isDoctor) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              UserProfileScreen(id: user.id, isDoctor: isDoctor),
                        ),
                      );
                    }
                  },
                  child: Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(width: 4),
              ],
            )
          ],
        ),
      );
}
