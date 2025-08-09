class UserModel {
  final String uid;
  final String? firstName;
  final String? lastName;
  final String email;
  final String? mobileNumber;

  UserModel({required this.uid, this.firstName, this.lastName, required this.email, this.mobileNumber});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      mobileNumber: map['mobileNumber']
    );
  }

  Map<String, dynamic> toMap() => {
    'uid': uid,
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
    'mobileNumber': mobileNumber,
  };
}
