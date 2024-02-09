import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/models/common_mixin/firestore_mixin.dart';

class ChatSubCollectionModel with FirestoreModel{
  final String senderId;
  final String lastMessage;
  final Timestamp time;
  final bool isRead;

  ChatSubCollectionModel({required this.senderId, required this.lastMessage, required this.time, required this.isRead});


  @override
  Map<String, dynamic> toMap() {
    return {
     FirebaseConstants.fieldChatSubCollectionSenderId:senderId,
     FirebaseConstants.fieldChatSubCollectionLastMessage:lastMessage,
     FirebaseConstants.fieldChatSubCollectionTime:time,
     FirebaseConstants.fieldChatSubCollectionIsRead:isRead
    };
  }
  
}

