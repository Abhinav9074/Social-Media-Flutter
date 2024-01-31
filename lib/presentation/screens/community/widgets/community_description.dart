import 'package:connected/presentation/core/themes/theme.dart';
import 'package:flutter/material.dart';

class CommunityDescription extends StatelessWidget {
  final TextEditingController controller;

  const CommunityDescription({super.key, required this.controller});


  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextFormField(
              controller: controller,
              maxLength: 5000,
              maxLines: 6,
              decoration: const InputDecoration(
                hintText: 'Description (optional)',
                hintStyle: MyTextStyle.optionTextMediumLight,
                border: OutlineInputBorder()
              ),
            ),
          );
  }
}