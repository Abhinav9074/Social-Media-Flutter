import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/models/common_mixin/firestore_mixin.dart';

class CommunityPostModel with FirestoreModel{
   String? message;
   String? image;
   String? alertMsg;
   bool alert;
   String communityId;
   String userId;
   String time;

  CommunityPostModel({this.message,  this.image,this.alertMsg,required this.alert,required this.communityId,required this.userId,required this.time});
  
  @override
  Map<String, dynamic> toMap() {
   return{
    FirebaseConstants.fieldCommunityPostMessage:message,
    FirebaseConstants.fieldCommunityPostImage:image,
    FirebaseConstants.fieldCommunityPostAlertMsg:alertMsg,
    FirebaseConstants.fieldCommunityPostIsAltert:alert,
    FirebaseConstants.fieldCommunityId:communityId,
    FirebaseConstants.fieldCommunityPostUserId:userId,
    FirebaseConstants.fieldCommunityPostTime:time
   };
  }
  
}