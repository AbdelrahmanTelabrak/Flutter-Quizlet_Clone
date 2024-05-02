import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget basicFormField(
    {required String hint,
    TextEditingController? controller,
    required FormFieldValidator validator,
    bool enabled = true,
    Function(String)? onChanged,
    TextInputType keyboardType = TextInputType.text,
    FocusNode? focusNode}) {
  return TextFormField(
    validator: validator,
    onChanged: onChanged,
    controller: controller,
    enabled: enabled,
    keyboardType: keyboardType,
    minLines: 1,
    maxLines: null,
    focusNode: focusNode,
    decoration: InputDecoration(
      // contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade800, width: 1),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade800, width: 2),
      ),
      hintText: hint,
      hintStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.grey,
      ),
      errorStyle: const TextStyle(height: 0),
    ),
  );
}

Widget basicFilledFormField(
    {required String hint,
    TextEditingController? controller,
    required FormFieldValidator validator,
    bool enabled = true,
    Function(String)? onChanged,
    TextInputType keyboardType = TextInputType.text}) {
  return TextFormField(
    maxLines: 1,
    validator: validator,
    onChanged: onChanged,
    controller: controller,
    enabled: enabled,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      hintText: hint,
      hintStyle: const TextStyle(
        fontSize: 14,
        color: Color(0xff939BB4),
      ),
      filled: true,
      fillColor: const Color(0xffF6F7FB),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
      errorStyle: const TextStyle(height: 0),
    ),
  );
}

class PasswordFormField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;

  final Function showHidePassword;

  final bool obscureText;

  PasswordFormField({
    Key? key,
    required this.hint,
    this.controller,
    required this.validator,
    this.onChanged,
    required this.showHidePassword,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      maxLines: 1,
      validator: validator,
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: Color(0xff939BB4),
        ),
        filled: true,
        fillColor: const Color(0xffF6F7FB),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none),
        suffixIcon: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/visibility_off.svg',
            color: Color(0xff586380),
          ),
          onPressed: () {
            showHidePassword();
          },
        ),
        errorStyle: const TextStyle(height: 0),
      ),
    );
  }
}
