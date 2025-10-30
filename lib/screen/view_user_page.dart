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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Hero(
                        tag: userId,
                        child: CircleAvatar(
                          radius: 56,
                          backgroundImage: userData['image'] != ''
                              ? FileImage(File(userData['image']))
                              : const AssetImage('assets/images/avatar_default.png') as ImageProvider,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        userData['username'] ?? '',
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Center(
                      child: Text(
                        userData['email'] ?? '',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(height: 1),
                    const SizedBox(height: 12),
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.person_outline),
                      title: const Text('Username'),
                      subtitle: Text(userData['username'] ?? ''),
                    ),
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.email_outlined),
                      title: const Text('Email'),
                      subtitle: Text(userData['email'] ?? ''),
                    ),
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.lock_outline),
                      title: const Text('Password'),
                      subtitle: Text(userData['password'] ?? ''),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => EditUserPage(userId: userId, userData: userData),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit),
                            label: const Text('Sửa'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                            onPressed: () => _deleteUser(context),
                            icon: const Icon(Icons.delete_outline),
                            label: const Text('Xóa'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
