import 'package:connected/presentation/core/themes/theme.dart';
import 'package:flutter/material.dart';

class AllSnackBars {
  static void commonSnackbar({required BuildContext context,required String title,required String content,required Color bg}){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        content,
        textScaler: TextScaler.noScaling,
        style: MyTextStyle.snackBarText,
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: bg,
    ));
  }
}
