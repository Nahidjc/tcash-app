class UserDetails {
  String? id;
  String? username;
  String? email;
  String? name;
  int? userType;
  double? currentBalance;
  int? accountNumber;
  String? mobileNo;
  String? profilePic;

  UserDetails({
    this.id,
    this.username,
    this.email,
    this.name,
    this.userType,
    this.currentBalance,
    this.accountNumber,
    this.mobileNo,
    this.profilePic,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      name: json['name'],
      userType: json['userType'],
      currentBalance: json['currentBalance']?.toDouble(),
      accountNumber: json['accountNumber'],
      mobileNo: json['mobileNo'],
      profilePic: json['profilePic'],
    );
  }
}
