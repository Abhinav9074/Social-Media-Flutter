
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';

Stream<List<Map<String, dynamic>>> follwoingDiscussionList() async* {
  final dataStream = FirebaseFirestore.instance
      .collection(FirebaseConstants.discussionDb).orderBy(FirebaseConstants.fieldDiscussionCreatedTime,descending: true)
      .snapshots();

  final userDeatils = await FirebaseFirestore.instance
      .collection(FirebaseConstants.userDb)
      .doc(UserDbFunctions().userId)
      .get();

  await for (QuerySnapshot snapshot in dataStream) {
    final filteredList = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final docId = doc.id;
      return {'id': docId, ...data};
    }).where((data) {
      final userId = data[FirebaseConstants.fieldDiscussionUserId];
      final userFollowing = userDeatils[FirebaseConstants.fieldFollowing] as List<dynamic>?;
      final userFollowers = userDeatils[FirebaseConstants.fieldFollowers] as List<dynamic>?;



      return userFollowers!.contains(userId)||userFollowing!.contains(userId);
    }).toList();

    yield filteredList;
  }
}
