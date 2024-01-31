import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/repository/gemini_configuration.dart';

abstract class Gemini {
  Future<void> addInterests(
      {required String discssionId, required String description});
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
    List<String> str=res.text.split('[').join().split(']').join().split(',');
    Future.forEach(str, (element)async{
      log(element.split('"').join());
      await FirebaseFirestore.instance
        .collection(FirebaseConstants.discussionDb)
        .doc(discssionId)
        .update({
      FirebaseConstants.fieldDiscussionTags: FieldValue.arrayUnion([element.split('"').join()])
    });

    await FirebaseFirestore.instance.
    collection(FirebaseConstants.interestsDb)
    .doc(FirebaseConstants.interestDbId)
    .update({FirebaseConstants.fieldInterests:FieldValue.arrayUnion([element.split('"').join()])});
    });
    
  }
}
