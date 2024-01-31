import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/models/common_mixin/firestore_mixin.dart';

class DiscussionModel with FirestoreModel{
  final String title;
  final String image;
  final String description;
  final List<int> likes;
  final List<int> disLikes;
  final String userId;
  final DateTime time;
  final List<String>contributions;
  final bool edited;
  final List<String>tags;

  DiscussionModel({required this.title, required this.image, required this.description, required this.likes, required this.disLikes, required this.userId, required this.contributions, required this.edited, required this.tags,required this.time});
  
  
  @override
  Map<String, dynamic> toMap() {
    return {
      FirebaseConstants.fieldDiscussionTitle:title,
      FirebaseConstants.fieldDiscussionImage:image,
      FirebaseConstants.fieldDiscussionDescription:description,
      FirebaseConstants.fieldDiscussionLikes:likes,
      FirebaseConstants.fieldDiscussionDisLikes:disLikes,
      FirebaseConstants.fieldDiscussionContribution:contributions,
      FirebaseConstants.fieldDiscussionEdited:edited,
      FirebaseConstants.fieldDiscussionTags:tags,
      FirebaseConstants.fieldDiscussionUserId:userId,
      FirebaseConstants.fieldDiscussionCreatedTime:time,
    };
  }
}