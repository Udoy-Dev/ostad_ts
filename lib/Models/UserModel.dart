class UserModel {
  final String? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? mobile;
  final String? createdDate;

  UserModel({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.mobile,
    this.createdDate,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      mobile: json['mobile'],
      createdDate: json['createdDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
      'createdDate': createdDate,
    };
  }
}