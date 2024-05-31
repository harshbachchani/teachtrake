import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:teachtrake/data/repositories/student_repository.dart';
import 'package:teachtrake/features/personalization/controllers/user_controller.dart';
import 'package:teachtrake/features/record/controllers/student_controller.dart';
import 'package:teachtrake/features/record/controllers/update_controller.dart';
import 'package:teachtrake/features/record/screen/update_delete_student/update_student.dart';
import 'package:teachtrake/utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StudentController());
    final updateController = Get.put(UpdateController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(HSizes.defaultSpace),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: FutureBuilder(
                  future: StudentRepository.instance.fetchStudents(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error while loading data',
                            style: Theme.of(context).textTheme.titleLarge),
                      );
                    } else if (snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          'No Record Found',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      );
                    }
                    final students = snapshot.data!;
                    return ListView.builder(
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        final student = students[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              bottom: HSizes.spaceBtwItems),
                          child: InkWell(
                            onTap: () {
                              updateController.updateDetails(student);
                              Get.to(() => const UpdateStudentScreen());
                            },
                            child: ListTile(
                              title: Text(
                                student.fullName,
                                style: const TextStyle(fontSize: 16),
                              ),
                              subtitle: Row(
                                children: [
                                  const Icon(Iconsax.calendar),
                                  const SizedBox(width: HSizes.sm),
                                  Text(student.dob!.toString().split(' ')[0]),
                                ],
                              ),
                              trailing: Text(
                                student.gender,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
            )),
      ),
    );
  }
}
