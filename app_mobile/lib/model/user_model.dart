class UserModel {
  final int? id;
  final String name;
  final String? username;
  final String? email;
  final String? token;
  final String avatar;

  const UserModel({
    this.id,
    required this.name,
    this.username,
    this.email,
    this.token,
    this.avatar = '',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'] ?? json['full_name'] ?? json['username'] ?? '',
      username: json['username'],
      email: json['email'],
      token: json['token'] ?? json['access_token'],
      avatar: json['avatar'] ?? '',
    );
  }

  UserModel copyWith({
    int? id,
    String? name,
    String? username,
    String? email,
    String? token,
    String? avatar,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      token: token ?? this.token,
      avatar: avatar ?? this.avatar,
    );
  }
}