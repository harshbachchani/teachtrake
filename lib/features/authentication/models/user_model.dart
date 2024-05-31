import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String email;
  String phonenumber;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phonenumber,
  });

  String get fullName => '$firstName $lastName';

  static List<String> nameParts(fullName) => fullName.split(" ");

  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";
    String camelCaseUsername = "$firstName$lastName";
    String usernamewithPrefix = "user_$camelCaseUsername";
    return usernamewithPrefix;
  }

  static UserModel empty() => UserModel(
        id: '',
        firstName: '',
        lastName: '',
        email: '',
        phonenumber: '',
      );

  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Email': email,
      'PhoneNumber': phonenumber,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'],
        email: data['Email'],
        phonenumber: data['PhoneNumber'],
      );
    }
    return UserModel.empty();
  }
}
