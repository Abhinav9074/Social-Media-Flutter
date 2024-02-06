import 'package:connected/presentation/core/themes/theme.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings',style: MyTextStyle.optionTextMediumLight,),
      ),

      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //bar1
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              width: double.infinity,
              height: 20,
              color: const Color.fromARGB(255, 215, 214, 214),
              child: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text('Support',style: MyTextStyle.greyHeadingTextSmall,),
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.fromLTRB(20,10, 5, 10),
            child: Text('Report an Issue',style: MyTextStyle.logoutText,),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 5, 10),
            child: Text('Help Center',style: MyTextStyle.descriptionText,),
          ),


          //bar2
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              width: double.infinity,
              height: 20,
              color: const Color.fromARGB(255, 215, 214, 214),
              child: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text('Info',style: MyTextStyle.greyHeadingTextSmall,),
              ),
            ),
          ),
          

          const Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 5, 10),
            child: Text('Version 1.0.0',style: MyTextStyle.descriptionText,),
          ),
        ],
      ),
    );
  }
}