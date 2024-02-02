// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/domain/models/report_model/discussion_report_model.dart';
import 'package:connected/domain/models/report_model/user_report_model.dart';
import 'package:connected/presentation/core/snackbars/common_snackbar.dart';
import 'package:connected/presentation/screens/main_page/screens/main_page.dart';
import 'package:flutter/material.dart';

abstract class ReportDb {
Future<void>reportUser({required String userId,required String description});
Future<void>reportDiscussion({required String discussionId,required String description});
}

class ReportDbFunctions extends ReportDb {
  ReportDbFunctions._internal();
  static ReportDbFunctions instance = ReportDbFunctions._internal();
  factory ReportDbFunctions() {
    return instance;
  }
  
  @override
  Future<void> reportDiscussion({required String discussionId, required String description}) async{

    //creating a model
    final value = DiscussionReport(reporterId: UserDbFunctions().userId, reportedDiscussionId: discussionId, description: description);

    await FirebaseFirestore.instance.collection(FirebaseConstants.discussionReportDb).add(value.toMap());

    //snackbar
    AllSnackBars.commonSnackbar(context: mainPageContext, title: 'Successful', content: 'Your Report Has Been Submitted', bg: Colors.green);
  }
  
  @override
  Future<void> reportUser({required String userId, required String description}) async{
    //creating a model
    final value = UserReportModel(reporterId: UserDbFunctions().userId, reportedUserId: userId, description: description);

    await FirebaseFirestore.instance.collection(FirebaseConstants.userReportDb).add(value.toMap());

    //snackbar
    AllSnackBars.commonSnackbar(context: mainPageContext, title: 'Successful', content: 'Your Report Has Been Submitted', bg: Colors.green);
  }
  
 

  
}
