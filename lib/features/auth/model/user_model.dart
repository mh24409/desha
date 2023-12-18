class UserModel {
  String? trackingID;
  String? token;
  int? userId;
  String? userName;
  String? userImage;
  String? email;
  int? employeeId;

  UserModel(
      {this.userName,
      this.userImage,
      this.email,
      this.userId,
      this.token,
      this.trackingID,
      this.employeeId
      });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        userId: json['profile']['id'],
        email: json['profile']['email'],
        userImage: json['profile']['image'],
        userName: json['profile']['full_name'],
        token: json['token'],
        employeeId: json['employee_id'],
        trackingID: json['trackingID']);
  }
}
