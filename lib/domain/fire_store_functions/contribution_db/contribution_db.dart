import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/models/contribution_model/contribution_model.dart';
import 'package:connected/presentation/core/snackbars/common_snackbar.dart';
import 'package:connected/presentation/screens/main_page/screens/main_page.dart';
import 'package:flutter/material.dart';

abstract class ContributionDb {
  Future<void> addContribution(ContributionModel data);
}

class ContributionDbFunctions extends ContributionDb {
  ContributionDbFunctions._internal();
  static ContributionDbFunctions instance = ContributionDbFunctions._internal();
  factory ContributionDbFunctions() {
    return instance;
  }

  //create contribution
  @override
  Future<void> addContribution(ContributionModel data) async {
    final ref =
        FirebaseFirestore.instance.collection(FirebaseConstants.contributionDb);
    final id = await ref.add(data.toMap());
    // ignore: use_build_context_synchronously
    AllSnackBars.commonSnackbar(
        context: mainPageContext,
        title: 'Success',
        content: 'Posted Successfully',
        bg: Colors.green);
    //adding the collection id to discussion db
    await FirebaseFirestore.instance
        .collection(FirebaseConstants.discussionDb)
        .doc(data.discssionId)
        .update({
      FirebaseConstants.fieldDiscussionContribution:
          FieldValue.arrayUnion([id.id])
    });
  }
}
