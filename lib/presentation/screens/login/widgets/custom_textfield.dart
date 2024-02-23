import 'package:connected/presentation/core/themes/theme.dart';
import 'package:flutter/material.dart';

class CustomCredentialTextField extends StatelessWidget {
  final String heading;
  final String hint;
  final bool obscuredText;
  final TextEditingController controller;
  final Icon sufficIcon;

  const CustomCredentialTextField({super.key, required this.heading, required this.hint, required this.obscuredText, required this.controller, required this.sufficIcon});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(heading,style: MyTextStyle.greyHeadingTextSmall,),
          ),
          TextFormField(
            controller: controller,
            style: MyTextStyle.descriptionText,
            obscureText: obscuredText,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              suffixIcon: sufficIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
              )
            ),
          ),
        ],
      ),
    );
  }
}