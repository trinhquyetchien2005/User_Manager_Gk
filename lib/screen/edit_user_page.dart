import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class EditUserPage extends StatefulWidget {
  final String userId;
  final Map<String, dynamic> userData;

  const EditUserPage({super.key, required this.userId, required this.userData});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _usernameController =
        TextEditingController(text: widget.userData['username']);
    _emailController = TextEditingController(text: widget.userData['email']);
    _passwordController =
        TextEditingController(text: widget.userData['password']);
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _updateUser() async {
    await FirebaseFirestore.instance.collection('users').doc(widget.userId).update({
      'username': _usernameController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
      'image': _imageFile?.path ?? widget.userData['image'],
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sửa người dùng")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 40,
                backgroundImage: _imageFile != null
                    ? FileImage(_imageFile!)
                    : (widget.userData['image'] != ''
                        ? FileImage(File(widget.userData['image']))
                        : const AssetImage('assets/images/avatar_default.png')
                            as ImageProvider),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _updateUser, child: const Text("Cập nhật"))
          ],
        ),
      ),
    );
  }
}
