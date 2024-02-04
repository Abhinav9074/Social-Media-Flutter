import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';

Stream<List<dynamic>> notificationStream() async* {
  final dataStream = FirebaseFirestore.instance
      .collection(FirebaseConstants.notificationDb)
      .orderBy(FirebaseConstants.fieldNotificationTimeStamp, descending: true)
      .snapshots();

  await for (QuerySnapshot snapshot in dataStream) {
    final filteredList = snapshot.docs.map((doc) => doc.data()).where((data) {
      // Replace this with your filtering criteria
      return (data as Map<String, dynamic>)[FirebaseConstants.fieldNotificationReceivedUser] == UserDbFunctions().userId;
    }).toList();

    yield filteredList;
  }
}
