// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/common/functions/gemini_functions/gemini_functions.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/domain/models/dicsussion_model/discussion_model.dart';
import 'package:connected/domain/shared_prefrences/login_logout/login_logout.dart';
import 'package:connected/presentation/core/snackbars/common_snackbar.dart';
import 'package:connected/presentation/screens/main_page/screens/main_page.dart';
import 'package:flutter/material.dart';

abstract class DiscussionDb {
  Future<void> addDiscussion(DiscussionModel data);
  Future<void> removeDiscussion(String data);
  Future<void> editDiscussion(DiscussionModel data, String discussionId);
  Future<void> likeDiscussion(String discussionId);
  Future<void> removeLikeDiscussion(String discussionId);
  Future<bool> checkLike(String discussionId);
}

class DiscussionDbFunctions extends DiscussionDb {
  DiscussionDbFunctions._internal();
  static DiscussionDbFunctions instance = DiscussionDbFunctions._internal();
  factory DiscussionDbFunctions() {
    return instance;
  }

  //create a discussion function
  @override
  Future<void> addDiscussion(DiscussionModel data) async {
    final discussionDb =
        FirebaseFirestore.instance.collection(FirebaseConstants.discussionDb);
    final id = await discussionDb.add(data.toMap());

    //adding the discussion id to user db
    await FirebaseFirestore.instance
        .collection(FirebaseConstants.userDb)
        .doc(await SharedPrefLogin.getUserId())
        .update({
      FirebaseConstants.fieldDiscussions: FieldValue.arrayUnion([id.id])
    });

    //showing snakbar
    AllSnackBars.commonSnackbar(
        context: mainPageContext,
        title: 'Posted',
        content: 'Posted Successfully',
        bg: Colors.green);

    //adding tags to interestdb and discussion using GEMINI AI
    await GeminiFunctions()
        .addInterests(discssionId: id.id, description: data.description);
  }

  //Like a disscussion
  @override
  Future<void> likeDiscussion(String discussionId) async {
    await FirebaseFirestore.instance
        .collection(FirebaseConstants.discussionDb)
        .doc(discussionId)
        .update({
      FirebaseConstants.fieldDiscussionLikes:
          FieldValue.arrayUnion([await SharedPrefLogin.getUserId()])
    });

    await FirebaseFirestore.instance
        .collection(FirebaseConstants.userDb)
        .doc(await SharedPrefLogin.getUserId())
        .update({
      FirebaseConstants.fieldLiked: FieldValue.arrayUnion([discussionId])
    });
  }

  @override
  Future<void> removeLikeDiscussion(String discussionId) async {
    await FirebaseFirestore.instance
        .collection(FirebaseConstants.discussionDb)
        .doc(discussionId)
        .update({
      FirebaseConstants.fieldDiscussionLikes:
          FieldValue.arrayRemove([await SharedPrefLogin.getUserId()])
    });

    await FirebaseFirestore.instance
        .collection(FirebaseConstants.userDb)
        .doc(await SharedPrefLogin.getUserId())
        .update({
      FirebaseConstants.fieldLiked: FieldValue.arrayRemove([discussionId])
    });
  }

  @override
  Future<bool> checkLike(String discussionId) async {
    final data = await FirebaseFirestore.instance
        .collection(FirebaseConstants.userDb)
        .doc(await SharedPrefLogin.getUserId())
        .get();
    if (data[FirebaseConstants.fieldLiked].contains(discussionId)) {
      return true;
    }
    return false;
  }

  @override
  Future<void> editDiscussion(DiscussionModel data, String discussionId) async {
    //creating collection refrence
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection(FirebaseConstants.discussionDb)
        .doc(discussionId);

    //creating a map to update
    Map<String, dynamic> fieldsToUpdate = {
      FirebaseConstants.fieldDiscussionTitle: data.title,
      FirebaseConstants.fieldDiscussionDescription: data.description,
      FirebaseConstants.fieldDiscussionCreatedTime: data.time,
      FirebaseConstants.fieldDiscussionEdited: true,
    };

    //updating the fields
    await documentReference.update(fieldsToUpdate);

    //showing snakbar
    AllSnackBars.commonSnackbar(
        context: mainPageContext,
        title: 'Posted',
        content: 'Updated Successfully',
        bg: Colors.green);

    //adding tags to interestdb and discussion using GEMINI AI
    await GeminiFunctions()
        .addInterests(discssionId: discussionId, description: data.description);
  }
  
  @override
  Future<void> removeDiscussion(String data) async{

    //deleting from main db 
    await FirebaseFirestore.instance.collection(FirebaseConstants.discussionDb).doc(data).delete();

    //deteting from user list
    await FirebaseFirestore.instance.collection(FirebaseConstants.userDb).doc(UserDbFunctions().userId).update({FirebaseConstants.fieldDiscussions:FieldValue.arrayRemove([data])});

    AllSnackBars.commonSnackbar(context: mainPageContext, title: 'Success', content: 'Deleted Successfully', bg: Colors.green);
  }
}
