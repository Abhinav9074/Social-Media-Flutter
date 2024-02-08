import 'package:connected/presentation/core/constants/texts.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions',style: MyTextStyle.commonButtonText,),
      ),

      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            child: SizedBox(width: MediaQuery.of(context).size.width,
            child: const Text(TextConstants.terms1,style: MyTextStyle.descriptionText,textAlign: TextAlign.justify,),),
          ),

          Padding(padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
          child: SizedBox(width: MediaQuery.of(context).size.width,
          child: const Text('Use of the App',style: MyTextStyle.discussionHeadingText,),
          ),
          ),


          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: SizedBox(width: MediaQuery.of(context).size.width,
            child: const Text(TextConstants.terms2,style: MyTextStyle.descriptionText,textAlign: TextAlign.justify,),),
          ),

          Padding(padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
          child: SizedBox(width: MediaQuery.of(context).size.width,
          child: const Text('User Content',style: MyTextStyle.discussionHeadingText,),
          ),
          ),


           Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: SizedBox(width: MediaQuery.of(context).size.width,
            child: const Text(TextConstants.terms3,style: MyTextStyle.descriptionText,textAlign: TextAlign.justify,),),
          ),


          Padding(padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
          child: SizedBox(width: MediaQuery.of(context).size.width,
          child: const Text('Intellectual Property Rights',style: MyTextStyle.discussionHeadingText,),
          ),
          ),


          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 20),
            child: SizedBox(width: MediaQuery.of(context).size.width,
            child: const Text(TextConstants.terms4,style: MyTextStyle.descriptionText,textAlign: TextAlign.justify,),),
          ),
        ],
              ),
    );
  }
}