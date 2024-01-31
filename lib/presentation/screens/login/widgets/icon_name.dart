import 'package:connected/presentation/core/constants/texts.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:flutter/material.dart';

class IconAndHeading extends StatelessWidget {
  const IconAndHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return     Column(
                children: [
                  Image.asset('assets/icons/login_icon.png',height: 100,width: 100,),
                  const SizedBox(height: 20,),
                  const Text(TextConstants.loginText,style: MyTextStyle.greyHeadingText,textAlign: TextAlign.center,textScaler: TextScaler.noScaling,),
                ],
              );
  }
}