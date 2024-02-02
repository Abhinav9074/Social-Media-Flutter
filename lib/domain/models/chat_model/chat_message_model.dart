import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/models/common_mixin/firestore_mixin.dart';

class ChatMessageModel with FirestoreModel{
  final String senderId;
  final String receiverId;
  final String message;
  final String time;
  final Timestamp timestamp;

  ChatMessageModel({required this.senderId, required this.receiverId, required this.message, required this.time,required this.timestamp});
  
  @override
  Map<String, dynamic> toMap() {
    return {
      FirebaseConstants.fieldchatSenderId:senderId,
      FirebaseConstants.fieldchatReceiverId:receiverId,
      FirebaseConstants.fieldchatMessage:message,
      FirebaseConstants.fieldchatTime:time,
      FirebaseConstants.fieldChatTimeStamp:timestamp,
    };
  }

  
}