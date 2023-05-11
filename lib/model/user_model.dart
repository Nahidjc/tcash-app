class UserModel {
  final String accessToken;
  final String message;
  final UserInfo user;
  final int statusCode;

  UserModel({
    required this.accessToken,
    required this.message,
    required this.user,
    required this.statusCode,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      accessToken: json['accessToken'],
      message: json['message'],
      user: UserInfo.fromJson(json['user']),
      statusCode: json['statusCode'],
    );
  }
}

class UserInfo {
  final String id;
  final String fullName;
  final String email;
  final String userName;
  final String role;

  UserInfo({
    required this.id,
    required this.fullName,
    required this.email,
    required this.userName,
    required this.role,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      userName: json['userName'],
      role: json['role'],
    );
  }
}
