import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/models/common_mixin/firestore_mixin.dart';

class UserReportModel with FirestoreModel{
  final String reporterId;
  final String reportedUserId;
  final String description;

  UserReportModel({required this.reporterId, required this.reportedUserId, required this.description});
  
  @override
  Map<String, dynamic> toMap() {

    return{
      FirebaseConstants.fieldReporterId:reporterId,
      FirebaseConstants.fieldReportedUserId:reportedUserId,
      FirebaseConstants.fieldReportDescription:description,
    };
  
  }
}