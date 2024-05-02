import 'package:flutter/material.dart';
import 'package:quizlet_clone/view/register/register_page.dart';
import 'package:quizlet_clone/view/widgets/buttons.dart';
import 'package:quizlet_clone/view/widgets/texts.dart';
import 'package:quizlet_clone/viewmodel/authentication/login/login_viewmodel.dart';

class LoginButtonsSection extends StatelessWidget {
  final LoginViewModel viewModel;
  final VoidCallback onTapSignUp;

  const LoginButtonsSection(
      {super.key, required this.viewModel, required this.onTapSignUp});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        filledFullWidthButton(
          onPressed: () {
            viewModel.login(context);
            FocusScope.of(context).unfocus();
          },
          child: semiBoldText('Log in', size: 14, color: Colors.white),
        ),
        const SizedBox(height: 20),
        outlinedFullWidthButton(
          onPressed: onTapSignUp,
          child: semiBoldText('New to Quizlet? Create an account',
              size: 14, color: const Color(0xff586380)),
        )
      ],
    );
  }
}
