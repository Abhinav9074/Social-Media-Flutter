import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/models/common_mixin/firestore_mixin.dart';

class ContributionModel with FirestoreModel{
  final String description;
  final String image;
  final String contributer;
  final String discssionId;
  final DateTime time;

  ContributionModel({required this.description, required this.image, required this.contributer,required this.discssionId,required this.time});

  @override
  Map<String, dynamic> toMap() {
    return{
      FirebaseConstants.fieldDiscussionDescription:description,
      FirebaseConstants.fieldDiscussionImage:image,
      FirebaseConstants.fieldDiscussionContributer:contributer,
      FirebaseConstants.fieldDiscussionDiscussionId:discssionId,
      FirebaseConstants.fieldContributedTime:time,
    };
  }
}