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
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 32,
                backgroundImage: userData['image'] != ''
                    ? FileImage(File(userData['image']))
                    : const AssetImage('assets/images/avatar_default.png') as ImageProvider,
              ),
              const SizedBox(height: 12),
              Text(
                userData['username'] ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                userData['email'] ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
