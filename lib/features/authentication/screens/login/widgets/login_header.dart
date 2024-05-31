import 'package:flutter/material.dart';
import 'package:teachtrake/utils/constants/image_string.dart';
import 'package:teachtrake/utils/constants/sizes.dart';
import 'package:teachtrake/utils/constants/text_string.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Image(
          height: 150,
          image: AssetImage(HImages.applogo),
        ),
        Text(HTextString.loginTitle,
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: HSizes.sm),
      ],
    );
  }
}
