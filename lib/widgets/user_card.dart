import 'dart:io';
import 'package:flutter/material.dart';
import '../screen/view_user_page.dart';

class UserCard extends StatelessWidget {
  final String userId;
  final Map<String, dynamic> userData;

  const UserCard({super.key, required this.userId, required this.userData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ViewUserPage(userId: userId, userData: userData)));
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: userData['image'] != ''
                  ? FileImage(File(userData['image']))
                  : const AssetImage('assets/images/avatar_default.png')
                      as ImageProvider,
            ),
            const SizedBox(height: 10),
            Text(userData['username']),
            Text(userData['email']),
          ],
        ),
      ),
    );
  }
}
