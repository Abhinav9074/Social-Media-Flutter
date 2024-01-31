import 'package:connected/presentation/core/themes/theme.dart';
import 'package:flutter/widgets.dart';

class LogoAndHeading extends StatelessWidget {
  final String heading;
  const LogoAndHeading({super.key, required this.heading});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/icons/icon-yellow.png',
          height: 60,
          width: 60,
        ),
         Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(heading,
              style: MyTextStyle.commonHeadingText,
              textScaler: TextScaler.noScaling),
        )
      ],
    );
  }
}
