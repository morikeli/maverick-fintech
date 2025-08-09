class UserModel {
  final String uid;
  final String? firstName;
  final String? lastName;
  final String email;
  final String? mobileNumber;
  final String? profilePicture;

  UserModel({required this.uid, this.firstName, this.lastName, required this.email, this.mobileNumber, this.profilePicture});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      mobileNumber: map['mobileNumber'],
      profilePicture: map['profilePicture'],
    );
  }

  Map<String, dynamic> toMap() => {
    'uid': uid,
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
    'mobileNumber': mobileNumber,
    'profilePicture': profilePicture,
  };


  UserModel copyWith({
    String? profilePicture,
  }) {
    return UserModel(
      uid: uid,
      firstName: firstName,
      lastName: lastName,
      email: email,
      mobileNumber: mobileNumber,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }
}
