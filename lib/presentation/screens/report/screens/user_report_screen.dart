// ignore_for_file: use_build_context_synchronously

import 'package:connected/domain/fire_store_functions/report_db/report_db_functions.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:flutter/material.dart';

class UserReportScreen extends StatelessWidget {
  final String userId;

  const UserReportScreen({super.key, required this.userId});
  

  @override
  Widget build(BuildContext context) {
    TextEditingController textCont =TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report User',style: MyTextStyle.discussionHeadingText,),
      ),
      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
            child: Text('Tell Us About the Issue you have faced',style: MyTextStyle.optionTextMedium,),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: textCont,
              maxLength: 5000,
              maxLines: 6,
              decoration: const InputDecoration(
                hintText: 'Description',
                hintStyle: MyTextStyle.optionTextMediumLight,
                border: OutlineInputBorder()
              ),
            ),
          )
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Submit',style: MyTextStyle.commonButtonTextWhite,),
        backgroundColor: Colors.red,
        onPressed: ()async{
          if(textCont.text.trim().isNotEmpty){
            await ReportDbFunctions().reportUser(userId: userId, description: textCont.text);
            Navigator.of(context).pop();
          }
        },
        ),
    );
  }
}
