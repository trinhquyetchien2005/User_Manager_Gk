import 'dart:io';
import 'package:flutter/material.dart';
import 'edit_user_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewUserPage extends StatelessWidget {
  final String userId;
  final Map<String, dynamic> userData;

  const ViewUserPage({super.key, required this.userId, required this.userData});

  Future<void> _deleteUser(BuildContext context) async {
    final confirmed = await showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text("Xác nhận xóa"),
              content: const Text("Bạn có chắc muốn xóa user này?"),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Hủy")),
                TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Xóa")),
              ],
            ));
    if (confirmed == true) {
      await FirebaseFirestore.instance.collection('users').doc(userId).delete();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Thông tin user")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: userData['image'] != ''
                  ? FileImage(File(userData['image']))
                  : const AssetImage('assets/images/avatar_default.png')
                      as ImageProvider,
            ),
            const SizedBox(height: 20),
            Text("Username: ${userData['username']}"),
            Text("Email: ${userData['email']}"),
            Text("Password: ${userData['password']}"),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              EditUserPage(userId: userId, userData: userData)));
                },
                child: const Text("Sửa")),
            const SizedBox(height: 10),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () => _deleteUser(context),
                child: const Text("Xóa")),
          ],
        ),
      ),
    );
  }
}
