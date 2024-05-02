import 'package:flutter/material.dart';
import 'package:quizlet_clone/view/login/login_button_section.dart';
import 'package:quizlet_clone/view/login/login_form.dart';
import 'package:quizlet_clone/view/widgets/buttons.dart';
import 'package:quizlet_clone/view/widgets/commons.dart';
import 'package:quizlet_clone/view/widgets/texts.dart';
import 'package:quizlet_clone/viewmodel/authentication/login/login_viewmodel.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onTapSignUp;

  const LoginPage({super.key, required this.onTapSignUp});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginViewModel viewModel = LoginViewModel();

  bool _obsercure = true;

  void showHidePassword() {
    _obsercure = !_obsercure;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      children: [
                        googleFullWidthButton(),
                        const SizedBox(height: 25),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            const Divider(),
                            // Divider
                            Container(
                              width: 70,
                              alignment: Alignment.center,
                              color: Colors.white,
                              child: semiBoldText('or email',
                                  color: const Color(0xff586380)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        LoginForm(
                          viewModel: viewModel,
                          showHidePassword: showHidePassword,
                          obscureText: _obsercure,
                        ),
                        const SizedBox(height: 25),
                        termsConditionsRichText(),
                      ],
                    ),
                    Spacer(),

                    /// =====================   Buttons   ========================
                    // Expanded(child: Container(color: Colors.blue,)),
                    LoginButtonsSection(viewModel: viewModel, onTapSignUp: widget.onTapSignUp),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ));
  }
}
