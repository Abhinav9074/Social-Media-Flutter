// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/domain/repository/gemini_configuration.dart';
import 'package:connected/presentation/core/snackbars/common_snackbar.dart';
import 'package:connected/presentation/screens/main_page/screens/main_page.dart';
import 'package:flutter/material.dart';

abstract class Gemini {
  Future<void> addInterests(
      {required String discssionId, required String description});
  Future<String> aiGenerate({required String initialKeywords});
  Future<String> aiEnhance({required String text});
  Future<String> checkSpam({required String text});
}

class GeminiFunctions extends Gemini {
  GeminiFunctions._internal();
  static GeminiFunctions instance = GeminiFunctions._internal();
  factory GeminiFunctions() {
    return instance;
  }

  @override
  Future<void> addInterests(
      {required String discssionId, required String description}) async {
    dynamic res = await GeminiModel.gemini.generateFromText(
        '$description : extract five common single or double word tags that are related to this description, in the form of an array, must be in the form of array');
    log(res.text);
    List<String> str = res.text.split('[').join().split(']').join().split(',');
    Future.forEach(str, (element) async {
      log(element.split('"').join());

      //Adding generated interest to discussion's tags field
      await FirebaseFirestore.instance
          .collection(FirebaseConstants.discussionDb)
          .doc(discssionId)
          .update({
        FirebaseConstants.fieldDiscussionTags:
            FieldValue.arrayUnion([element.split('"').join().toLowerCase()])
      });

      //Adding the generated interests to interest db
      await FirebaseFirestore.instance
          .collection(FirebaseConstants.interestsDb)
          .doc(FirebaseConstants.interestDbId)
          .update({
        FirebaseConstants.fieldInterests:
            FieldValue.arrayUnion([element.split('"').join().toLowerCase()])
      });

      //Adding the generated interests to user's interest field
      await FirebaseFirestore.instance
          .collection(FirebaseConstants.userDb)
          .doc(UserDbFunctions().userId)
          .update({
        FirebaseConstants.fieldInterest:
            FieldValue.arrayUnion([element.split('"').join().toLowerCase()])
      });
    });
  }

  //function for generating ai description
  @override
  Future<String> aiGenerate({required String initialKeywords}) async {
    //checking spam
    final testRes = await checkSpam(text: initialKeywords);
    if (testRes.toUpperCase() == 'NO') {
      AllSnackBars.commonSnackbar(
          context: mainPageContext,
          title: '',
          content: 'Please Enter Something Meaningful',
          bg: Colors.red);
      return initialKeywords;
    }

    try {
      dynamic res = await GeminiModel.gemini.generateFromText(
          '$initialKeywords : elaborate this into a brief description ina  single pharagraph only');
      log(res.text);
      return res.text;
    } catch (e) {
      throw Exception(e);
    }
  }


  //function to check whether the written text spam or not
  @override
  Future<String> checkSpam({required String text}) async {
    try {
      dynamic res = await GeminiModel.gemini.generateFromText(
          '$text : if the typed text is meaningful reply me YES or if it is a random typed letters reply me NO');
      log(res.text);
      return res.text;
    } catch (e) {
      throw Exception(e);
    }
  }
  
  @override
  Future<String> aiEnhance({required String text}) async{

    //checking spam
    final testRes = await checkSpam(text: text);
    if (testRes.toUpperCase() == 'NO') {
      AllSnackBars.commonSnackbar(
          context: mainPageContext,
          title: '',
          content: 'Please Enter Something Meaningful',
          bg: Colors.red);
      return text;
    }

    
    try {
      dynamic res = await GeminiModel.gemini.generateFromText(
          '$text : clear all the spelling mistakes and rephrase this without changing the meaning , dont add anything more');
      log(res.text);
      return res.text;
    } catch (e) {
      throw Exception(e);
    }
  }
}
