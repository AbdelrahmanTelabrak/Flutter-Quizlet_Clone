
import 'package:flutter/material.dart';
import 'package:quizlet_clone/main.dart';

import '../../viewmodel/authentication/register/register_viewmodel.dart';
import '../widgets/buttons.dart';
import '../widgets/texts.dart';

class RegisterButtonSection extends StatelessWidget {
  final RegisterViewModel viewModel;
  final VoidCallback onTapLogin;

  const RegisterButtonSection({super.key, required this.viewModel, required this.onTapLogin});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        filledFullWidthButton(
          onPressed: () => viewModel.register(context),
          child: semiBoldText('Sign Up', size: 14, color: Colors.white),
        ),
        const SizedBox(height: 20),
        outlinedFullWidthButton(
          onPressed: onTapLogin,
          child: semiBoldText('Already have an account? Log in',
              size: 14, color: const Color(0xff586380)),
        )
      ],
    );
  }
}
