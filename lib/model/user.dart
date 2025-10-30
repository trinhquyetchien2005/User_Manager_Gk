class User {
  final String username;
  final String email;
  final String password;
  final String image; // link ảnh (Firebase Storage URL)

  User({
    required this.username,
    required this.email,
    required this.password,
    required this.image,
  });

  // Tạo object từ Firestore (Map -> User)
  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      password: data['password'] ?? '',
      image: data['image'] ?? '',
    );
  }

  // Chuyển object thành Map (User -> Map) để lưu lên Firestore
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'image': image,
    };
  }
}
