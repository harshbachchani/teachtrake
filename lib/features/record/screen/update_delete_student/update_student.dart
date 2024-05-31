import 'package:flutter/material.dart';
import 'package:teachtrake/common/image/rounded_image.dart';
import 'package:teachtrake/features/record/screen/update_delete_student/update_form.dart';
import 'package:teachtrake/utils/constants/image_string.dart';
import 'package:teachtrake/utils/constants/sizes.dart';

class UpdateStudentScreen extends StatelessWidget {
  const UpdateStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(HSizes.defaultSpace),
        child: Column(
          children: [
            HRoundedImage(imageUrl: HImages.studentImg, height: 250),
            SizedBox(height: HSizes.spaceBtwSections),
            UpdateStudentForm(),
          ],
        ),
      ),
    );
  }
}
