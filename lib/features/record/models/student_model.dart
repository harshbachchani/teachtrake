import 'package:cloud_firestore/cloud_firestore.dart';

class StudentModel {
  final String id;
  String firstName;
  String lastName;
  final String gender;
  final DateTime? dob;
  final String teacherId;

  StudentModel({
    this.id = '',
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.dob,
    required this.teacherId,
  });

  String get fullName => '$firstName $lastName';

  StudentModel get empty => StudentModel(
      firstName: '', lastName: '', gender: '', dob: null, teacherId: '');
  Map<String, dynamic> toJson() {
    return {
      'TeacherId': teacherId,
      'FirstName': firstName,
      'LastName': lastName,
      'DOB': dob,
      'Gender': gender,
    };
  }

  factory StudentModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return StudentModel(
      id: document.id,
      firstName: data['FirstName'] ?? '',
      lastName: data['LastName'],
      gender: data['Gender'],
      dob: (data['DOB'] as Timestamp).toDate(),
      teacherId: data['TeacherId'],
    );
  }
}
