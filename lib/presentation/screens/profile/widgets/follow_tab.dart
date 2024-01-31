import 'package:connected/presentation/core/themes/theme.dart';
import 'package:flutter/material.dart';

class FollowTab extends StatelessWidget {
  final String action;
  final String count;

  const FollowTab({super.key, required this.action, required this.count});
  

  @override
  Widget build(BuildContext context) {
    return Column(
                  children: [
                    Text(action,style: MyTextStyle.greyHeadingTextSmall,textScaler: TextScaler.noScaling,),
                    Text(count,style: MyTextStyle.commonHeadingText,textScaler: TextScaler.noScaling,),
                  ],
                );
  }
}