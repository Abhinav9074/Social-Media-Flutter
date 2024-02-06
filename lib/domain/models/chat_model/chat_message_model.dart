import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/models/common_mixin/firestore_mixin.dart';

class ChatMessageModel with FirestoreModel{
  final String senderId;
  final String receiverId;
  final String message;
  final String time;
  final Timestamp timestamp;
  final bool isDiscussion;
  final String? discussionId;
  final String? discussionName;
  final bool isAlert;
  final String? alertMsg;

  ChatMessageModel({required this.senderId, required this.receiverId, required this.message, required this.time, required this.timestamp, required this.isDiscussion,this.discussionId,this.discussionName, required this.isAlert, this.alertMsg});

  
  
  @override
  Map<String, dynamic> toMap() {
    return {
      FirebaseConstants.fieldchatSenderId:senderId,
      FirebaseConstants.fieldchatReceiverId:receiverId,
      FirebaseConstants.fieldchatMessage:message,
      FirebaseConstants.fieldchatTime:time,
      FirebaseConstants.fieldChatTimeStamp:timestamp,
      FirebaseConstants.fieldChatIsDiscussion:isDiscussion,
      FirebaseConstants.fieldChatDiscussionId:discussionId,
      FirebaseConstants.fieldChatDiscussionName:discussionName,
      FirebaseConstants.fieldChatIsAlert:isAlert,
      FirebaseConstants.fieldChatlertMsg:alertMsg,
    };
  }


  
}