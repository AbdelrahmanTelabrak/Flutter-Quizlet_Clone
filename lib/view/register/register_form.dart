import 'package:flutter/material.dart';
import 'package:quizlet_clone/viewmodel/authentication/register/register_viewmodel.dart';

import '../widgets/textfields.dart';
import '../widgets/texts.dart';

class RegisterForm extends StatefulWidget {
  final RegisterViewModel viewModel;

  const RegisterForm({super.key, required this.viewModel});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool obscureText = true;
  List<String> monthsAbbreviation = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  void showHidePassword() {
    obscureText = !obscureText;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.viewModel.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    hintText: 'Month',
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      color: Color(0xff939BB4),
                    ),
                    filled: true,
                    fillColor: const Color(0xffF6F7FB),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none),
                    errorStyle: const TextStyle(height: 0),
                  ),
                  items: List<DropdownMenuItem<String>>.generate(
                    12,
                    (index) => DropdownMenuItem(
                      value: (index + 1).toString(),
                      child: mediumText(monthsAbbreviation[index]),
                    ),
                  ),
                  onChanged: widget.viewModel.updateMonth,
                  validator: widget.viewModel.validateMonth,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    hintText: 'Day',
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      color: Color(0xff939BB4),
                    ),
                    filled: true,
                    fillColor: const Color(0xffF6F7FB),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none),
                    errorStyle: const TextStyle(height: 0),
                  ),
                  items: List<DropdownMenuItem<String>>.generate(
                    31,
                    (index) => DropdownMenuItem(
                      value: (index + 1).toString(),
                      child: mediumText('${index + 1}'),
                    ),
                  ),
                  onChanged: widget.viewModel.updateDay,
                  validator: widget.viewModel.validateDay,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    hintText: 'Year',
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      color: Color(0xff939BB4),
                    ),
                    filled: true,
                    fillColor: const Color(0xffF6F7FB),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none),
                    errorStyle: const TextStyle(height: 0),
                  ),
                  items: List<DropdownMenuItem<String>>.generate(
                    100,
                    (index) => DropdownMenuItem(
                      value: (index + 1 + DateTime.now().year - 100).toString(),
                      child: mediumText(
                          '${index + 1 + DateTime.now().year - 100}'),
                    ),
                  ).reversed.toList(),
                  onChanged: (value) {
                    widget.viewModel.updateYear(value);
                    setState(() {});
                  },
                  validator: widget.viewModel.validateYear,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          semiBoldText('Email',
              color: const Color(0xff586380), align: TextAlign.start),
          const SizedBox(height: 6),
          basicFilledFormField(
            hint: 'Enter your email address',
            validator: widget.viewModel.validateEmail,
            onChanged: widget.viewModel.updateEmail,
          ),
          const SizedBox(height: 35),
          semiBoldText('Username',
              color: const Color(0xff586380), align: TextAlign.start),
          const SizedBox(height: 6),
          basicFilledFormField(
            hint: 'Choose your username',
            validator: widget.viewModel.validateUsername,
            onChanged: widget.viewModel.updateUsername,
          ),
          const SizedBox(height: 35),
          semiBoldText('Password',
              color: const Color(0xff586380), align: TextAlign.start),
          const SizedBox(height: 6),
          PasswordFormField(
            hint: 'Enter your password',
            validator: widget.viewModel.validatePassword,
            showHidePassword: showHidePassword,
            obscureText: obscureText,
            onChanged: widget.viewModel.updatePassword,
          ),
          if (widget.viewModel.birthDate.year != null &&
              DateTime.now().year - int.parse(widget.viewModel.birthDate.year!) >=18)
            Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    //CheckBox
                    Checkbox(
                      activeColor: const Color(0xff4255FF),
                      value: widget.viewModel.isTeacher,
                      onChanged: (value) => setState(() {widget.viewModel.changeType();}),
                    ),
                    Expanded(
                      child: regularText('I am a teacher', align: TextAlign.start),
                    ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}
