// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/models/location_model/location_model.dart';
import 'package:connected/domain/models/notification_model/notification_model.dart';
import 'package:connected/domain/models/user_model/user_model.dart';
import 'package:connected/domain/models/user_model/user_update_model.dart';
import 'package:connected/domain/repository/file_upload_repository.dart';
import 'package:connected/domain/shared_prefrences/login_logout/login_logout.dart';
import 'package:connected/presentation/core/snackbars/common_snackbar.dart';
import 'package:connected/presentation/screens/main_page/screens/main_page.dart';
import 'package:flutter/material.dart';

abstract class UserDb {
  Future<void> addUser(UserModel data);
  Future<bool> checkValue(
      {required String value, required String field, required String dbName});
  Future<void> followUser(String userId);
  Future<void> unFollowUser(String userId);
  Future<String> getId(String email);
  Future<void> saveUserId(String id);
  Future<bool> isFollowingState(String id);
  Future<bool> isFollowBackState(String id);
  Future<String> getUsername(String id);
  Future<bool> blockStatus(String email);
  Future<bool> blockStatusId();
  Future<void> addInterest(String interest);
  Future<void> removeInterest(String interest);
  Future<void> addLoactionData(LocationModel location);
  Future<void> updateUserData(
      {required UserUpdateModel data, required String image});
  Future<void> subscribeToPremium();
  Future<void> createNotification(NotificationModel data);
}

class UserDbFunctions extends UserDb {
  UserDbFunctions._internal();
  static UserDbFunctions instance = UserDbFunctions._internal();
  factory UserDbFunctions() {
    return instance;
  }

  //logged in user details stored here
  String userId = '';

//check a value exist or not
  @override
  Future<bool> checkValue(
      {required String value,
      required String field,
      required String dbName}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection(dbName)
          .where(field, isEqualTo: value)
          .get();
      if (snapshot.docs.isNotEmpty) {
        return true;
      }
      return false;
    } catch (error) {
      log('Error checking data $error');
      return false;
    }
  }

  ///User adding function
  @override
  Future<void> addUser(UserModel data) async {
    final CollectionReference user =
        FirebaseFirestore.instance.collection(FirebaseConstants.userDb);

    await user.add(data.toMap());
  }

  //follow a user
  @override
  Future<void> followUser(String userId) async {
    await FirebaseFirestore.instance
        .collection(FirebaseConstants.userDb)
        .doc(await SharedPrefLogin.getUserId())
        .update({
      FirebaseConstants.fieldFollowing: FieldValue.arrayUnion([userId])
    });

    await FirebaseFirestore.instance
        .collection(FirebaseConstants.userDb)
        .doc(userId)
        .update({
      FirebaseConstants.fieldFollowers:
          FieldValue.arrayUnion([await SharedPrefLogin.getUserId()])
    });

    final data = NotificationModel(
        message: 'Started Following You',
        otherUser: userId,
        time: DateTime.now(),
        timestamp: Timestamp.now(),
        userId: UserDbFunctions().userId);

    await createNotification(data);
  }

  //unfollow a user
  @override
  Future<void> unFollowUser(String userId) async {
    await FirebaseFirestore.instance
        .collection(FirebaseConstants.userDb)
        .doc(await SharedPrefLogin.getUserId())
        .update({
      FirebaseConstants.fieldFollowing: FieldValue.arrayRemove([userId])
    });

    await FirebaseFirestore.instance
        .collection(FirebaseConstants.userDb)
        .doc(userId)
        .update({
      FirebaseConstants.fieldFollowers:
          FieldValue.arrayRemove([await SharedPrefLogin.getUserId()])
    });
  }

  //get used ID using email
  @override
  Future<String> getId(String email) async {
    final data = await FirebaseFirestore.instance
        .collection(FirebaseConstants.userDb)
        .where(FirebaseConstants.fieldEmail, isEqualTo: email)
        .get();
    return data.docs.first.id;
  }

  //save user id , interests and follwoing list to a accessible type
  @override
  Future<void> saveUserId(String id) async {
    userId = await SharedPrefLogin.getUserId();
  }

  //check differient follwing states

  //following state
  @override
  Future<bool> isFollowingState(String id) async {
    final data = await FirebaseFirestore.instance
        .collection(FirebaseConstants.userDb)
        .doc(await SharedPrefLogin.getUserId())
        .get();
    if (data.get(FirebaseConstants.fieldFollowing).contains(id)) {
      return true;
    }
    return false;
  }

  //follow back state
  @override
  Future<bool> isFollowBackState(String id) async {
    final data = await FirebaseFirestore.instance
        .collection(FirebaseConstants.userDb)
        .doc(id)
        .get();
    if (data
        .get(FirebaseConstants.fieldFollowing)
        .contains(await SharedPrefLogin.getUserId())) {
      return true;
    }
    return false;
  }

  @override
  Future<String> getUsername(String id) async {
    final data = await FirebaseFirestore.instance
        .collection(FirebaseConstants.userDb)
        .doc(id)
        .get();
    return data[FirebaseConstants.fieldRealname];
  }

  @override
  Future<bool> blockStatusId() async {
    final data = await FirebaseFirestore.instance
        .collection(FirebaseConstants.userDb)
        .doc(userId)
        .get();
    if (data[FirebaseConstants.fieldUserBlocked] == true) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> blockStatus(String email) async {
    final data = await FirebaseFirestore.instance
        .collection(FirebaseConstants.userDb)
        .where(FirebaseConstants.fieldEmail, isEqualTo: email)
        .get();
    if (data.docs.first[FirebaseConstants.fieldUserBlocked] == true) {
      return true;
    }
    return false;
  }

  @override
  Future<void> addInterest(String interest) async {
    //updating user list
    await FirebaseFirestore.instance
        .collection(FirebaseConstants.userDb)
        .doc(userId)
        .update({
      FirebaseConstants.fieldInterest: FieldValue.arrayUnion([interest])
    });
  }

  @override
  Future<void> removeInterest(String interest) async {
    //updating user list
    await FirebaseFirestore.instance
        .collection(FirebaseConstants.userDb)
        .doc(userId)
        .update({
      FirebaseConstants.fieldInterest: FieldValue.arrayRemove([interest])
    });
  }

  @override
  Future<void> addLoactionData(LocationModel location) async {
    await FirebaseFirestore.instance
        .collection(FirebaseConstants.userDb)
        .doc(userId)
        .update({
      FirebaseConstants.fieldLattitude: location.lattitude,
      FirebaseConstants.fieldLongitude: location.longitude
    });
  }

  @override
  Future<void> updateUserData(
      {required UserUpdateModel data, String image = ''}) async {
    if (image == '') {
      await FirebaseFirestore.instance
          .collection(FirebaseConstants.userDb)
          .doc(userId)
          .update(data.toMap());
    } else {
      final upload = FileUploadRepository();
      String? img = await upload.uploadImage(File(image));
      final value = UserUpdateModel(
          image: img!,
          realName: data.realName,
          locationView: data.locationView,
          address: data.address,
          bio: data.bio);
      await FirebaseFirestore.instance
          .collection(FirebaseConstants.userDb)
          .doc(userId)
          .update(value.toMap());
    }

    //snackbar
    AllSnackBars.commonSnackbar(
        context: mainPageContext,
        title: 'Success',
        content: 'Data Updated',
        bg: Colors.green);
  }

  @override
  Future<void> subscribeToPremium() async {
    await FirebaseFirestore.instance
        .collection(FirebaseConstants.userDb)
        .doc(userId)
        .update({FirebaseConstants.fieldPremiumUser: true});

    //creating notification
    final data = NotificationModel(
        message: 'Congrats You Just Became Our VIP Member',
        otherUser: UserDbFunctions().userId,
        time: DateTime.now(),
        timestamp: Timestamp.now());

    await createNotification(data);
  }

  @override
  Future<void> createNotification(NotificationModel data) async {
    //adding the notification to notification db
    final id = await FirebaseFirestore.instance
        .collection(FirebaseConstants.notificationDb)
        .add(data.toMap());

    //adding the notification if to respective user's collection
    await FirebaseFirestore.instance
        .collection(FirebaseConstants.userDb)
        .doc(data.otherUser)
        .update({
      FirebaseConstants.filedNotifications: FieldValue.arrayUnion([id.id])
    });

    //updating the notification count in userdb
    await FirebaseFirestore.instance
        .collection(FirebaseConstants.userDb)
        .doc(data.otherUser)
        .update({
      FirebaseConstants.fieldNotificationCount: FieldValue.increment(1)
    });
  }

  Future<void> clearNotificationCount() async {
//updating the notification count in userdb
    await FirebaseFirestore.instance
        .collection(FirebaseConstants.userDb)
        .doc(UserDbFunctions().userId)
        .update({
      FirebaseConstants.fieldNotificationCount: 0
    });
  }
}
