import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/models/common_mixin/firestore_mixin.dart';

class InterestModel with FirestoreModel{
  final String interestName;

  InterestModel({required this.interestName});


  
  
  @override
  Map<String, dynamic> toMap() {
    return {
      FirebaseConstants.fieldInterests:interestName,
    };
  }
}