import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teachtrake/data/repositories/authentication_repository.dart';
import 'package:teachtrake/features/record/models/student_model.dart';
import 'package:teachtrake/utils/exceptions/firebase_exceptions.dart';
import 'package:teachtrake/utils/exceptions/format_exceptions.dart';
import 'package:teachtrake/utils/exceptions/platform_exceptions.dart';

class StudentRepository extends GetxController {
  static StudentRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<List<StudentModel>> fetchStudents() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        throw 'Unable to find user information. Try again in few minutes';
      }
      final result = await _db
          .collection('Students')
          .where('TeacherId', isEqualTo: userId)
          .get();
      return result.docs.map((e) => StudentModel.fromSnapshot(e)).toList();
    } catch (e) {
      throw 'Something Went Wrong while fetching order details.Try again after some time';
    }
  }

  Future<void> updateStudent(StudentModel student, String id) async {
    try {
      await _db.collection('Students').doc(id).update(student.toJson());
      await fetchStudents();
    } on FirebaseException catch (e) {
      throw HFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const HFormatException();
    } on PlatformException catch (e) {
      throw HPlatformException(e.code).message;
    } catch (e) {
      throw 'Something Went Wrong!!';
    }
  }

  Future<void> deleteStudent(String id) async {
    try {
      await _db.collection('Students').doc(id).delete();
      await fetchStudents();
    } on FirebaseException catch (e) {
      throw HFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const HFormatException();
    } on PlatformException catch (e) {
      throw HPlatformException(e.code).message;
    } catch (e) {
      throw 'Something Went Wrong!!';
    }
  }

  Future<void> addStudent(StudentModel student) async {
    try {
      await _db.collection('Students').doc().set(student.toJson());
    } on FirebaseException catch (e) {
      throw HFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const HFormatException();
    } on PlatformException catch (e) {
      throw HPlatformException(e.code).message;
    } catch (e) {
      throw 'Something Went Wrong!!';
    }
  }
}
