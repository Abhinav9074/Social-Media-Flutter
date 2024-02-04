import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/models/common_mixin/firestore_mixin.dart';

class NotificationModel with FirestoreModel{
  final String? userId;
  final String message;
  final String otherUser;
  final DateTime time;
  final Timestamp timestamp;

  NotificationModel({this.userId, required this.message, required this.otherUser, required this.time,required this.timestamp});
  
  @override
  Map<String, dynamic> toMap() {
    return {
      FirebaseConstants.fieldNotificationCreatedUser:userId,
      FirebaseConstants.fieldNotificationReceivedUser:otherUser,
      FirebaseConstants.fieldNotificationMessage:message,
      FirebaseConstants.fieldNotificationTime:time,
      FirebaseConstants.fieldNotificationTimeStamp:timestamp,
    };
  }
}