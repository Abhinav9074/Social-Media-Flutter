import 'package:connected/presentation/core/themes/theme.dart';
import 'package:flutter/material.dart';

class SideHeadingWidget extends StatelessWidget {
  final String heading;

  const SideHeadingWidget({super.key, required this.heading});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
      child: Text(heading,style: MyTextStyle.mediumBlackText,textScaler: TextScaler.noScaling,),
    );
  }
}