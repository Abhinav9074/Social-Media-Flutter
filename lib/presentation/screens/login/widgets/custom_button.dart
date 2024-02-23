import 'package:connected/presentation/core/themes/theme.dart';
import 'package:flutter/material.dart';

class CustomButtonLogin extends StatelessWidget {
  final String text;
  final Icon icon;
  final Function()? onPressed;

  const CustomButtonLogin({super.key, required this.text, required this.icon, this.onPressed});


  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.red)
      ),
      onPressed: onPressed, 
      icon: icon, 
      label: Text(text,style: MyTextStyle.commonButtonTextWhite,));
  }
}