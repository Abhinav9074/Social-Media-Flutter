import 'package:connected/presentation/screens/home/widgets/dissussion_ui.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: DisscussionUi()
    );
  }
}