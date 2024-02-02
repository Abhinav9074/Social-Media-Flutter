import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/models/common_mixin/firestore_mixin.dart';

class DiscussionReport with FirestoreModel{
  final String reporterId;
  final String reportedDiscussionId;
  final String description;

  DiscussionReport({required this.reporterId, required this.reportedDiscussionId, required this.description});
  
  @override
  Map<String, dynamic> toMap() {

    return{
      FirebaseConstants.fieldReporterId:reporterId,
      FirebaseConstants.fieldReportDescription:description,
      FirebaseConstants.fieldReportedDiscussionId:description,
    };
  
  }
}