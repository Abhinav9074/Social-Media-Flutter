import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/models/common_mixin/firestore_mixin.dart';
import 'package:connected/domain/models/community_model/community_notification_model.dart';
import 'package:connected/domain/models/community_model/community_post_model.dart';

class CommunityModel with FirestoreModel{
  final String name;
  final String description;
  final String image;
  final String adminId;
  final String typing;
  final List<CommunityPostModel> communityPosts;
  final DateTime createdTime;
  final bool private;
  final bool restricted;
  final List<String>members;
  final List<CommunityNotificationModel> communityNotifications;
  final List<String> requests;

  CommunityModel({required this.name, required this.description, required this.image, required this.adminId, required this.communityPosts, required this.createdTime, required this.private, required this.members, required this.communityNotifications,required this.requests,required this.typing,required this.restricted});

  

  @override
  Map<String, dynamic> toMap() {
    return{
      FirebaseConstants.fieldCommunityName:name,
      FirebaseConstants.fieldCommunityDescription:description,
      FirebaseConstants.fieldCommunityProfile:image,
      FirebaseConstants.fieldCommunityAdminId:adminId,
      FirebaseConstants.fieldCommunityPosts:communityPosts,
      FirebaseConstants.fieldCommunityCreatedTime:createdTime,
      FirebaseConstants.fieldCommunityPrivate:private,
      FirebaseConstants.fieldCommunityMembers:members,
      FirebaseConstants.fieldCommunityNotifications:communityNotifications,
      FirebaseConstants.fieldCommunityRequests:requests,
      FirebaseConstants.fieldCommunityTyping:typing,
      FirebaseConstants.fieldCommunityRestricted:restricted
    };
  }
}