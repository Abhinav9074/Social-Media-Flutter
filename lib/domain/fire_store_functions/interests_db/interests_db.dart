import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/models/interest_model/interest_model.dart';

abstract class InterestsDb{
  Future<void>addInterests(InterestModel interest);
}

class InterestsDbFunctions extends InterestsDb{
  InterestsDbFunctions._internal();
  static InterestsDbFunctions instance = InterestsDbFunctions._internal();
  factory InterestsDbFunctions() {
    return instance;
  }
  
  @override
  Future<void> addInterests(InterestModel interest) async{
    await FirebaseFirestore.instance.collection(FirebaseConstants.interestsDb).add(interest.toMap());
  }
}