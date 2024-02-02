
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/domain/models/chat_model/chat_message_model.dart';
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
  Future<void>sendChatMessage(String receiverId,String message)async{
    
    //create a new message
    final chatMessage = ChatMessageModel(senderId: UserDbFunctions().userId, receiverId: receiverId, message: message, time: DateFormat.jm().format(DateTime.now()),timestamp: Timestamp.now());
  
    //create chat room id for user pair
    List<String>ids=[UserDbFunctions().userId,receiverId];
    ids.sort();//for ensuring uniqueness
    String chatRoomId = ids.join("_");

    //add a new message to db
    await _firestore.collection(FirebaseConstants.chatRoom).doc(chatRoomId).collection(FirebaseConstants.messagesSubCollection).add(chatMessage.toMap());

  
  }

  //GET ALL MESSAGES
  Stream<QuerySnapshot>getChatMessages(String receiverId){
    //create chat room id for user pair
    List<String>ids=[UserDbFunctions().userId,receiverId];
    ids.sort();//for ensuring uniqueness
    String chatRoomId = ids.join("_");

    return _firestore.collection(FirebaseConstants.chatRoom).doc(chatRoomId).collection(FirebaseConstants.messagesSubCollection).orderBy('timestamp',descending: true).snapshots();
  }

}
