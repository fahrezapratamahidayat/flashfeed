class AuthResponse {
  final bool success;
  final String message;
  final UserData data;

  AuthResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      success: json['success'],
      message: json['message'],
      data: UserData.fromJson(json['data']),
    );
  }
}

class UserData {
  final User user;
  final String token;

  UserData({required this.user, required this.token});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(user: User.fromJson(json['user']), token: json['token']);
  }
}

class User {
  final String id;
  final String email;
  final String name;
  final String title;
  final String avatar;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.title,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      title: json['title'],
      avatar: json['avatar'],
    );
  }
}
