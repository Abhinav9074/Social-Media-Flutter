import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/domain/models/chat_model/chat_message_model.dart';
import 'package:connected/domain/models/chat_model/chat_sub_collection.dart';
import 'package:intl/intl.dart';

class ChatServices {
  //creating singleton for universal use
  ChatServices._internal();
  static ChatServices instance = ChatServices._internal();
  factory ChatServices() {
    return instance;
  }

  //creating instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //SEND MESSAGE
  Future<void> sendChatMessage(String receiverId, String message) async {
    //send date
    await createDateAlert(receiverId);

    //create a new message
    final chatMessage = ChatMessageModel(
        senderId: UserDbFunctions().userId,
        receiverId: receiverId,
        message: message,
        time: DateFormat.jm().format(DateTime.now()),
        timestamp: Timestamp.now(),
        isAlert: false,
        isDiscussion: false);

    //create chat room id for user pair
    List<String> ids = [UserDbFunctions().userId, receiverId];
    ids.sort(); //for ensuring uniqueness
    String chatRoomId = ids.join("_");

    //add a new message to db
    await _firestore
        .collection(FirebaseConstants.chatRoom)
        .doc(chatRoomId)
        .collection(FirebaseConstants.messagesSubCollection)
        .add(chatMessage.toMap());

    // //add the chat list to both user's display
    await showUnreadMessage(receiverId: receiverId, lastMessage: message);

    await showUnreadMessageForSender(receiverId: receiverId, lastMessage: message);
  }

  //SEND A DISCUSSION AS MESSAGE
  Future<void> shareDiscussion(
      String receiverId, String discussionId, String discussionName) async {
    await createDateAlert(receiverId);
    //create a new message
    final chatMessage = ChatMessageModel(
        senderId: UserDbFunctions().userId,
        receiverId: receiverId,
        message: '',
        time: DateFormat.jm().format(DateTime.now()),
        timestamp: Timestamp.now(),
        isAlert: false,
        isDiscussion: true,
        discussionId: discussionId,
        discussionName: discussionName);

    //create chat room id for user pair
    List<String> ids = [UserDbFunctions().userId, receiverId];
    ids.sort(); //for ensuring uniqueness
    String chatRoomId = ids.join("_");

    //add a new message to db
    await _firestore
        .collection(FirebaseConstants.chatRoom)
        .doc(chatRoomId)
        .collection(FirebaseConstants.messagesSubCollection)
        .add(chatMessage.toMap());

    // //add the chat list to both user's display
    await showUnreadMessage(
        receiverId: receiverId, lastMessage: 'Shared a discussion');

        await showUnreadMessageForSender(receiverId: receiverId, lastMessage: 'You Shared a discussion');
  }

  //CREATE A DATE ALERT IN CHAT
  Future<void> createDateAlert(String receiverId) async {
    //create a new message
    final chatMessage = ChatMessageModel(
        senderId: UserDbFunctions().userId,
        receiverId: receiverId,
        message: '',
        time: DateFormat.jm().format(DateTime.now()),
        timestamp: Timestamp.now(),
        isAlert: true,
        isDiscussion: false,
        alertMsg: DateTime.now().toString().substring(0, 10));

    //create chat room id for user pair
    List<String> ids = [UserDbFunctions().userId, receiverId];
    ids.sort(); //for ensuring uniqueness
    String chatRoomId = ids.join("_");

    //check the date is
    final data = await _firestore
        .collection(FirebaseConstants.chatRoom)
        .doc(chatRoomId)
        .collection(FirebaseConstants.messagesSubCollection)
        .where(FirebaseConstants.fieldChatlertMsg,
            isEqualTo: DateTime.now().toString().substring(0, 10))
        .get();

    if (data.docs.isEmpty) {
      await _firestore
          .collection(FirebaseConstants.chatRoom)
          .doc(chatRoomId)
          .collection(FirebaseConstants.messagesSubCollection)
          .add(chatMessage.toMap());
    }
  }

  //SHOW THE UNREAD CHAT IN RECEIVING USERS SIDE
  Future<void> showUnreadMessage(
      {required String receiverId,
      required String lastMessage,
      required}) async {
    //checking if there is any started chat in the user
    final collectionData = await FirebaseFirestore.instance
        .collection(FirebaseConstants.userDb)
        .doc(receiverId)
        .collection(FirebaseConstants.chatSubCollection)
        .get();

    if (collectionData.docs.isEmpty) {
      //adding to the receiving users account
      final value = ChatSubCollectionModel(
          senderId: UserDbFunctions().userId,
          lastMessage: lastMessage,
          time: Timestamp.now(),
          isRead: false);

      await FirebaseFirestore.instance
          .collection(FirebaseConstants.userDb)
          .doc(receiverId)
          .collection(FirebaseConstants.chatSubCollection)
          .add(value.toMap());

    } else {
      //checking if a specific user chat is there or not
      final singleData = await FirebaseFirestore.instance
          .collection(FirebaseConstants.userDb)
          .doc(receiverId)
          .collection(FirebaseConstants.chatSubCollection)
          .where(FirebaseConstants.fieldChatSubCollectionSenderId,
              isEqualTo: UserDbFunctions().userId)
          .get();

      //there is no chat with the specific user so adding a new one
      if (singleData.docs.isEmpty) {
        final value = ChatSubCollectionModel(
            senderId: UserDbFunctions().userId,
            lastMessage: lastMessage,
            time: Timestamp.now(),
            isRead: false);

        await FirebaseFirestore.instance
            .collection(FirebaseConstants.userDb)
            .doc(receiverId)
            .collection(FirebaseConstants.chatSubCollection)
            .add(value.toMap());

        //there is already a chat , so updating that one
      } else {
        //getting the id to update the chat collection field
        final id = await FirebaseFirestore.instance
            .collection(FirebaseConstants.userDb)
            .doc(receiverId)
            .collection(FirebaseConstants.chatSubCollection)
            .where(FirebaseConstants.fieldChatSubCollectionSenderId,
                isEqualTo: UserDbFunctions().userId)
            .get();

        //updating
        await FirebaseFirestore.instance
            .collection(FirebaseConstants.userDb)
            .doc(receiverId)
            .collection(FirebaseConstants.chatSubCollection)
            .doc(id.docs.first.id)
            .update({
          FirebaseConstants.fieldChatSubCollectionLastMessage: lastMessage,
          FirebaseConstants.fieldChatSubCollectionTime: Timestamp.now(),
          FirebaseConstants.fieldChatSubCollectionIsRead: false
        });
      }
    }
  }



  //SHOW THE UNREAD CHAT IN RECEIVING USERS SIDE
  Future<void> showUnreadMessageForSender(
      {required String receiverId,
      required String lastMessage,
      required}) async {
    //checking if there is any started chat in the user
    final collectionData = await FirebaseFirestore.instance
        .collection(FirebaseConstants.userDb)
        .doc(UserDbFunctions().userId)
        .collection(FirebaseConstants.chatSubCollection)
        .get();

    if (collectionData.docs.isEmpty) {
      //adding to the receiving users account
      final value = ChatSubCollectionModel(
          senderId: receiverId,
          lastMessage: lastMessage,
          time: Timestamp.now(),
          isRead: true);

      await FirebaseFirestore.instance
          .collection(FirebaseConstants.userDb)
          .doc(UserDbFunctions().userId)
          .collection(FirebaseConstants.chatSubCollection)
          .add(value.toMap());

    } else {
      //checking if a specific user chat is there or not
      final singleData = await FirebaseFirestore.instance
          .collection(FirebaseConstants.userDb)
          .doc(UserDbFunctions().userId)
          .collection(FirebaseConstants.chatSubCollection)
          .where(FirebaseConstants.fieldChatSubCollectionSenderId,
              isEqualTo: receiverId)
          .get();

      //there is no chat with the specific user so adding a new one
      if (singleData.docs.isEmpty) {
        final value = ChatSubCollectionModel(
            senderId: receiverId,
            lastMessage: lastMessage,
            time: Timestamp.now(),
            isRead: true);

        await FirebaseFirestore.instance
            .collection(FirebaseConstants.userDb)
            .doc(UserDbFunctions().userId)
            .collection(FirebaseConstants.chatSubCollection)
            .add(value.toMap());

        //there is already a chat , so updating that one
      } else {
        //getting the id to update the chat collection field
        final id = await FirebaseFirestore.instance
            .collection(FirebaseConstants.userDb)
            .doc(UserDbFunctions().userId)
            .collection(FirebaseConstants.chatSubCollection)
            .where(FirebaseConstants.fieldChatSubCollectionSenderId,
                isEqualTo: receiverId)
            .get();

        //updating
        await FirebaseFirestore.instance
            .collection(FirebaseConstants.userDb)
            .doc(UserDbFunctions().userId)
            .collection(FirebaseConstants.chatSubCollection)
            .doc(id.docs.first.id)
            .update({
          FirebaseConstants.fieldChatSubCollectionLastMessage: lastMessage,
          FirebaseConstants.fieldChatSubCollectionTime: Timestamp.now(),
          FirebaseConstants.fieldChatSubCollectionIsRead: true
        });
      }
    }
  }


  //MARK UNREAD 
  Future<void>markUnread(String id)async{
    await FirebaseFirestore.instance.collection(FirebaseConstants.userDb).doc(UserDbFunctions().userId)
    .collection(FirebaseConstants.chatSubCollection).doc(id).update({FirebaseConstants.fieldChatSubCollectionIsRead:true});
  }









  //GET ALL MESSAGES
  Stream<QuerySnapshot> getChatMessages(String receiverId) {
    //create chat room id for user pair
    List<String> ids = [UserDbFunctions().userId, receiverId];
    ids.sort(); //for ensuring uniqueness
    String chatRoomId = ids.join("_");

    return _firestore
        .collection(FirebaseConstants.chatRoom)
        .doc(chatRoomId)
        .collection(FirebaseConstants.messagesSubCollection)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
