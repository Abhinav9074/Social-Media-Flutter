import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/domain/models/community_model/community_post_model.dart';
import 'package:connected/domain/repository/file_upload_repository.dart';
import 'package:intl/intl.dart';

abstract class CommunityPostDb {
  Future<void> createPost(CommunityPostModel data);
}

class CommunityPostDbFunctions extends CommunityPostDb {
  CommunityPostDbFunctions._internal();
  static CommunityPostDbFunctions instance =
      CommunityPostDbFunctions._internal();
  factory CommunityPostDbFunctions() {
    return instance;
  }

  @override
  Future<void> createPost(CommunityPostModel data) async {
   
    String? img = '';
    if (data.image != '') {
      final upload = FileUploadRepository();
      img = await upload.uploadImage(File(data.image!));
    }
    final val = CommunityPostModel(
        alert: data.alert,
        communityId: data.communityId,
        message: data.message,
        image: img,
        userId: UserDbFunctions().userId,
        alertMsg: data.alertMsg,
        time: DateFormat.jm().format(DateTime.now()));

    final id = await FirebaseFirestore.instance
        .collection(FirebaseConstants.communityPostDb)
        .add(val.toMap());

    await FirebaseFirestore.instance
        .collection(FirebaseConstants.communityDb)
        .doc(data.communityId)
        .update({
      FirebaseConstants.fieldCommunityPosts: FieldValue.arrayUnion([id.id])
    });
  }
}
