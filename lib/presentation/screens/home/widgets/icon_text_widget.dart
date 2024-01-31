import 'package:connected/presentation/core/themes/theme.dart';
import 'package:flutter/material.dart';

class IconTextWidget extends StatelessWidget {
  final Icon icon;
  final String text;

  const IconTextWidget({super.key, required this.icon, required this.text});


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: (){}, icon: icon),
        Text(text,style: MyTextStyle.commonButtonText,)
      ],
    );
  }
}