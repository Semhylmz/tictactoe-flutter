class UserModel {
  final String userUuid;
  final String userName;

  const UserModel({
    required this.userUuid,
    required this.userName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userUuid: json['userUuid'],
      userName: json['userName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userUuid': userUuid,
      'userName': userName,
    };
  }
}
