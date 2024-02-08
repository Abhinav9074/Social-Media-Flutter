import 'package:connected/presentation/core/constants/texts.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy',style: MyTextStyle.commonButtonText,),
      ),

      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            child: SizedBox(width: MediaQuery.of(context).size.width,
            child: const Text(TextConstants.privacy1,style: MyTextStyle.descriptionText,textAlign: TextAlign.justify,),),
          ),

          Padding(padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
          child: SizedBox(width: MediaQuery.of(context).size.width,
          child: const Text('Information We Collect',style: MyTextStyle.discussionHeadingText,),
          ),
          ),


          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: SizedBox(width: MediaQuery.of(context).size.width,
            child: const Text(TextConstants.privacy2,style: MyTextStyle.descriptionText,textAlign: TextAlign.justify,),),
          ),

          Padding(padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
          child: SizedBox(width: MediaQuery.of(context).size.width,
          child: const Text('How We Use Your Information',style: MyTextStyle.discussionHeadingText,),
          ),
          ),


           Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: SizedBox(width: MediaQuery.of(context).size.width,
            child: const Text(TextConstants.privacy3,style: MyTextStyle.descriptionText,textAlign: TextAlign.justify,),),
          ),


          Padding(padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
          child: SizedBox(width: MediaQuery.of(context).size.width,
          child: const Text('Data Security',style: MyTextStyle.discussionHeadingText,),
          ),
          ),


          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: SizedBox(width: MediaQuery.of(context).size.width,
            child: const Text(TextConstants.privacy4,style: MyTextStyle.descriptionText,textAlign: TextAlign.justify,),),
          ),
        ],
              ),
    );
  }
}