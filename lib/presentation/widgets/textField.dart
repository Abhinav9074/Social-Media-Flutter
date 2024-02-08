import 'package:connected/presentation/core/themes/theme.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController textCont;
  final Function()? suffixOnPressed;
  final Function()? prefixOnPressed;
  final dynamic suffixIcon;
  final Widget prefixIcon;
  final bool readOnly;

  const CustomTextField(
      {super.key,
      required this.hint,
      required this.textCont,
      required this.suffixOnPressed,
      required this.prefixOnPressed,
      required this.suffixIcon,
      required this.prefixIcon,
      required this.readOnly});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: TextFormField(
        readOnly: readOnly,
        controller: textCont,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
            suffixIcon: IconButton(onPressed: suffixOnPressed, icon: suffixIcon),
            prefixIcon: IconButton(onPressed: prefixOnPressed, icon: const Icon(Icons.message)),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(40)),
            hintText: hint,
            hintStyle: MyTextStyle.descriptionText,
            filled: true),
      ),
    );
  }
}
