

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';

Stream<List<Map<String, dynamic>>> discussionSearchStream(String searchVal) async* {
  final dataStream = FirebaseFirestore.instance
      .collection(FirebaseConstants.discussionDb)
      .snapshots();

  await for (QuerySnapshot snapshot in dataStream) {
    final filteredList = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final docId = doc.id;
      
      return {'id': docId, ...data};
    }).where((data) {
      return data[FirebaseConstants.fieldDiscussionTitle].toLowerCase().contains(searchVal);
    }).toList();

    yield filteredList;
  }
}

