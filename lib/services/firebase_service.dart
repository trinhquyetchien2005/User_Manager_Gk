
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../model/user.dart';

class FirebaseService {
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('users');

  // 🔹 Thêm user mới
  Future<void> createUser(User user) async {
    await usersRef.add(user.toMap());
  }

  // 🔹 Lấy danh sách tất cả user (1 lần)
  Future<List<Map<String, dynamic>>> getUsers() async {
    final snapshot = await usersRef.get();
    return snapshot.docs
        .map((doc) => {
              'docId': doc.id, // dùng để update/delete
              ...doc.data() as Map<String, dynamic>,
            })
        .toList();
  }

  // 🔹 Cập nhật user theo docId
  Future<void> updateUser(String docId, User user) async {
    await usersRef.doc(docId).update(user.toMap());
  }

  // 🔹 Xóa user theo docId
  Future<void> deleteUser(String docId) async {
    await usersRef.doc(docId).delete();
  }

  // 🔹 Upload ảnh lên Firebase Storage và trả về link
  Future<String> uploadImage(File imageFile) async {
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = FirebaseStorage.instance.ref().child('user_images/$fileName');

    final uploadTask = await ref.putFile(imageFile);
    final url = await uploadTask.ref.getDownloadURL();
    return url;
  }

  // 🔹 Stream realtime: dùng trong HomePage để list user tự động cập nhật
  Stream<List<Map<String, dynamic>>> streamUsers() {
    return usersRef.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => {
                'docId': doc.id,
                ...doc.data() as Map<String, dynamic>,
              })
          .toList();
    });
  }
}
