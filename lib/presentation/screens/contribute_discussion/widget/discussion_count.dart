import 'package:connected/presentation/core/themes/theme.dart';
import 'package:flutter/material.dart';

class DiscussionCountWidget extends StatelessWidget {
  final int count;

  const DiscussionCountWidget({super.key, required this.count});
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Discussions',style: MyTextStyle.largeText,),
          Text('$count Total Discussions',style: MyTextStyle.greyHeadingTextSmall,)
        ],
      ),
    );
  }
}