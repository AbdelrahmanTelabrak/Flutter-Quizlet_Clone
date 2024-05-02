import 'package:flutter/material.dart';
import 'package:quizlet_clone/view/widgets/textfields.dart';
import 'package:quizlet_clone/view/widgets/texts.dart';
import 'package:quizlet_clone/viewmodel/authentication/login/login_viewmodel.dart';

class LoginForm extends StatelessWidget {
  final LoginViewModel viewModel;
  final Function showHidePassword;
  final bool obscureText;

  const LoginForm({super.key, required this.viewModel, required this.showHidePassword, required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: viewModel.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          semiBoldText('Email',
              color: const Color(0xff586380), align: TextAlign.start),
          const SizedBox(height: 6),
          basicFilledFormField(
            hint: 'Enter your email address',
            validator: viewModel.validateEmail,
            onChanged: viewModel.updateEmail,
          ),
          const SizedBox(height: 35),
          semiBoldText('Password',
              color: const Color(0xff586380), align: TextAlign.start),
          const SizedBox(height: 6),
          PasswordFormField(
            hint: 'Enter your password',
            validator: viewModel.validatePassword,
            showHidePassword: showHidePassword,
            obscureText: obscureText,
            onChanged: viewModel.updatePassword,
          ),
        ],
      ),
    );
  }
}
