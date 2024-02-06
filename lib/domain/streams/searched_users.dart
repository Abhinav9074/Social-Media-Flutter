import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';

Stream<List<Map<String, dynamic>>> userSearchStream(String searchVal) async* {
  final dataStream = FirebaseFirestore.instance
      .collection(FirebaseConstants.userDb)
      .snapshots();

  await for (QuerySnapshot snapshot in dataStream) {
    final filteredList = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final docId = doc.id;

      log(data.toString());
      
      return {'id': docId, ...data};
    }).where((data) {
      return data[FirebaseConstants.fieldRealname].toLowerCase().contains(searchVal);
    }).toList();

    yield filteredList;
  }
}

