import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';

Stream<List<Map<String, dynamic>>> interestDiscussionList() async* {
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
      final discussionTags = data[FirebaseConstants.fieldDiscussionTags] as List<dynamic>;
      final userInterest = userDeatils[FirebaseConstants.fieldInterest] as List<dynamic>?;

      return userInterest != null && discussionTags.any((element) => userInterest.contains(element));
    }).toList();

    yield filteredList;
  }
}
