import 'package:flutter/material.dart';
import 'package:teachtrake/common/image/rounded_image.dart';
import 'package:teachtrake/features/record/screen/add_student/student_form.dart';
import 'package:teachtrake/utils/constants/image_string.dart';
import 'package:teachtrake/utils/constants/sizes.dart';

class AddStudentScreen extends StatelessWidget {
  const AddStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(HSizes.defaultSpace),
        child: Column(
          children: [
            HRoundedImage(imageUrl: HImages.studentImg, height: 250),
            SizedBox(height: HSizes.spaceBtwSections),
            StudentForm(),
          ],
        ),
      ),
    );
  }
}
