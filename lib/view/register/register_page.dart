import 'package:flutter/material.dart';
import 'package:quizlet_clone/view/register/register_button_section.dart';
import 'package:quizlet_clone/view/register/register_form.dart';
import 'package:quizlet_clone/view/widgets/commons.dart';
import 'package:quizlet_clone/viewmodel/authentication/register/register_viewmodel.dart';

import '../widgets/buttons.dart';
import '../widgets/texts.dart';

class RegisterPage extends StatefulWidget {

  final VoidCallback onTapLogin;
  const RegisterPage({super.key, required this.onTapLogin});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final RegisterViewModel _viewModel = RegisterViewModel();

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
                        googleFullWidthButton(context),
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
                        /// ================ Register Form ================
                        RegisterForm(viewModel: _viewModel),
                        /// ===============================================
                        // const SizedBox(height: 10),
                        // Row(
                        //   children: [
                        //     //CheckBox
                        //     Expanded(child: termsConditionsRichText(align: TextAlign.start)),
                        //   ],
                        // ),
                        const SizedBox(height: 15),
                      ],
                    ),
                    const Spacer(),
                    /// =====================   Buttons   ========================
                    RegisterButtonSection(viewModel: _viewModel, onTapLogin: widget.onTapLogin),
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
