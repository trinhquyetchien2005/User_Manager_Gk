
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  // 🔹 Đăng ký bằng email & password
  Future<String?> register(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // null nghĩa là thành công
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // 🔹 Đăng nhập bằng email & password
  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // 🔹 Đăng xuất
  Future<void> logout() async {
    await _auth.signOut();
    notifyListeners();
  }

  // 🔹 Kiểm tra login
  bool get isLoggedIn => _auth.currentUser != null;
}
