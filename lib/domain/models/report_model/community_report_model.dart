import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/models/common_mixin/firestore_mixin.dart';

class CommunityReportModel with FirestoreModel{
  final String reporterId;
  final String reportedCommunityId;
  final String description;

  CommunityReportModel({required this.reporterId, required this.reportedCommunityId, required this.description});
  
  @override
  Map<String, dynamic> toMap() {

    return{
      FirebaseConstants.fieldReporterId:reporterId,
      FirebaseConstants.fieldReportDescription:description,
      FirebaseConstants.fieldreportedCommunityId:reportedCommunityId,
    };
  
  }
}