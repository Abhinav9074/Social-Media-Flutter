import 'package:connected/presentation/core/themes/theme.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final Icon icon;
  final Function()? onPressed;

  const CommonButton({super.key, required this.text, required this.icon, this.onPressed});


  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed, 
      icon: icon ,
      label: Text(text,style: MyTextStyle.commonButtonText,),
      style: ButtonStyle(),
      );
  }
}