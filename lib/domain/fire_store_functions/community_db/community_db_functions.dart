// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/community_db/community_post_functions.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/domain/models/community_model/community_model.dart';
import 'package:connected/domain/models/community_model/community_post_model.dart';
import 'package:connected/presentation/core/snackbars/common_snackbar.dart';
import 'package:connected/presentation/screens/main_page/screens/main_page.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

abstract class CommunityDb {
  Future<void> createCommunity(CommunityModel data);
  Future<void> joinCommunity(String communityId);
  Future<void> joinPrivateCommunity(String communityId, String userId);
  Future<void> removeFromCommunity(String communityId, String userId);
  Future<void> userTyping(String userId, String communityId);
  Future<String> getCommunityName(
    String communityId,
  );
}

class CommunityDbFunctions extends CommunityDb {
  CommunityDbFunctions._internal();
  static CommunityDbFunctions instance = CommunityDbFunctions._internal();
  factory CommunityDbFunctions() {
    return instance;
  }

  //Function for creating community
  @override
  Future<void> createCommunity(CommunityModel data) async {
    //adding the community to community db
    final id = await FirebaseFirestore.instance
        .collection(FirebaseConstants.communityDb)
        .add(data.toMap());

    //addding the community id to user db
    await FirebaseFirestore.instance
        .collection(FirebaseConstants.userDb)
        .doc(UserDbFunctions().userId)
        .update({
      FirebaseConstants.fieldCommunities: FieldValue.arrayUnion([id.id])
    });

    //adding the community name for searching
    await FirebaseFirestore.instance
        .collection(FirebaseConstants.userDb)
        .doc(UserDbFunctions().userId)
        .update({
      FirebaseConstants.fieldCommunitiyNames:
          FieldValue.arrayUnion([await getCommunityName(id.id)])
    });

    //adding the date to the community chat list
    final dates = CommunityPostModel(
        alert: true,
        communityId: id.id,
        userId: UserDbFunctions().userId,
        alertMsg: DateTime.now().toString().substring(0, 10),
        image: '',
        time: '');
    await CommunityPostDbFunctions().createPost(dates);

    //adding alert to the community chat list

    final values = CommunityPostModel(
        alert: true,
        communityId: id.id,
        userId: UserDbFunctions().userId,
        alertMsg:
            '${await UserDbFunctions().getUsername(UserDbFunctions().userId)} Created This Community'
                .titleCase,
        image: '',
        time: '');
    await CommunityPostDbFunctions().createPost(values);

    //showing snackbar
    AllSnackBars.commonSnackbar(
        context: mainPageContext,
        title: 'Community Created',
        content: 'Community Created',
        bg: Colors.green);
  }

  //function for joining public and private community
  @override
  Future<void> joinCommunity(String communityId) async {
    //Getting the community details
    final data = await FirebaseFirestore.instance
        .collection(FirebaseConstants.communityDb)
        .doc(communityId)
        .get();

    //checking the community is private or public
    if (data[FirebaseConstants.fieldCommunityPrivate] == true) {
      //if private adding the request to community's request
      await FirebaseFirestore.instance
          .collection(FirebaseConstants.communityDb)
          .doc(communityId)
          .update({
        FirebaseConstants.fieldCommunityRequests:
            FieldValue.arrayUnion([UserDbFunctions().userId])
      });
    } else {
      //adding user to the public community
      await FirebaseFirestore.instance
          .collection(FirebaseConstants.communityDb)
          .doc(communityId)
          .update({
        FirebaseConstants.fieldCommunityMembers:
            FieldValue.arrayUnion([UserDbFunctions().userId])
      });

      //adding the community ID to users db
      await FirebaseFirestore.instance
          .collection(FirebaseConstants.userDb)
          .doc(UserDbFunctions().userId)
          .update({
        FirebaseConstants.fieldCommunities: FieldValue.arrayUnion([communityId])
      });

      //adding the community name to user db for searching
      await FirebaseFirestore.instance
          .collection(FirebaseConstants.userDb)
          .doc(UserDbFunctions().userId)
          .update({
        FirebaseConstants.fieldCommunitiyNames:
            FieldValue.arrayUnion([await getCommunityName(communityId)])
      });

      //checking whether the date exist or not
      final dateData = await FirebaseFirestore.instance
          .collection(FirebaseConstants.communityPostDb)
          .where(FirebaseConstants.fieldCommunityId, isEqualTo: communityId)
          .where(FirebaseConstants.fieldCommunityPostAlertMsg,
              isEqualTo: DateTime.now().toString().substring(0, 10))
          .get();
      if (dateData.docs.isEmpty) {
        //adding the date to the community chat list
        final dates = CommunityPostModel(
            alert: true,
            communityId: communityId,
            userId: UserDbFunctions().userId,
            alertMsg: DateTime.now().toString().substring(0, 10),
            image: '',
            time: '');
        await CommunityPostDbFunctions().createPost(dates);
      }

      //adding alert to the community chat list
      final values = CommunityPostModel(
          alert: true,
          communityId: communityId,
          userId: UserDbFunctions().userId,
          alertMsg:
              '${await UserDbFunctions().getUsername(UserDbFunctions().userId)} Joined This Community'
                  .titleCase,
          image: '',
          time: '');
      await CommunityPostDbFunctions().createPost(values);
    }
  }

  //function to add user to private community and accept the join request also
  @override
  Future<void> joinPrivateCommunity(String communityId, String userId) async {
    //adding user to the private community
    await FirebaseFirestore.instance
        .collection(FirebaseConstants.communityDb)
        .doc(communityId)
        .update({
      FirebaseConstants.fieldCommunityMembers: FieldValue.arrayUnion([userId])
    });

    //adding the community ID to users db
    await FirebaseFirestore.instance
        .collection(FirebaseConstants.userDb)
        .doc(userId)
        .update({
      FirebaseConstants.fieldCommunities: FieldValue.arrayUnion([communityId])
    });

    //checking whether the date exist or not
    final dateData = await FirebaseFirestore.instance
        .collection(FirebaseConstants.communityPostDb)
        .where(FirebaseConstants.fieldCommunityId, isEqualTo: communityId)
        .where(FirebaseConstants.fieldCommunityPostAlertMsg,
            isEqualTo: DateTime.now().toString().substring(0, 10))
        .get();
    if (dateData.docs.isEmpty) {
      //adding the date to the community chat list
      final dates = CommunityPostModel(
          alert: true,
          communityId: communityId,
          userId: userId,
          alertMsg: DateTime.now().toString().substring(0, 10),
          image: '',time: '');
      await CommunityPostDbFunctions().createPost(dates);
    }

    //adding the community name to user db for searching
    await FirebaseFirestore.instance
        .collection(FirebaseConstants.userDb)
        .doc(userId)
        .update({
      FirebaseConstants.fieldCommunitiyNames:
          FieldValue.arrayUnion([await getCommunityName(communityId)])
    });

    //adding alert to the community chat list

    final values = CommunityPostModel(
        alert: true,
        communityId: communityId,
        userId: userId,
        alertMsg:
            '${await UserDbFunctions().getUsername(userId)} Joined This Community'
                .titleCase,
        image: '',
        time: '');
    await CommunityPostDbFunctions().createPost(values);

    //removing the user from request of the community
    await FirebaseFirestore.instance
        .collection(FirebaseConstants.communityDb)
        .doc(communityId)
        .update({
      FirebaseConstants.fieldCommunityRequests: FieldValue.arrayRemove([userId])
    });
  }

  @override
  Future<void> removeFromCommunity(String communityId, String userId) async {
    //removing user from the community
    await FirebaseFirestore.instance
        .collection(FirebaseConstants.communityDb)
        .doc(communityId)
        .update({
      FirebaseConstants.fieldCommunityMembers: FieldValue.arrayRemove([userId])
    });

    //removing the community ID from users db
    await FirebaseFirestore.instance
        .collection(FirebaseConstants.userDb)
        .doc(userId)
        .update({
      FirebaseConstants.fieldCommunities: FieldValue.arrayRemove([communityId])
    });

    //checking whether the date exist or not
    final dateData = await FirebaseFirestore.instance
        .collection(FirebaseConstants.communityPostDb)
        .where(FirebaseConstants.fieldCommunityId, isEqualTo: communityId)
        .where(FirebaseConstants.fieldCommunityPostAlertMsg,
            isEqualTo: DateTime.now().toString().substring(0, 10))
        .get();
    if (dateData.docs.isEmpty) {
      //adding the date to the community chat list
      final dates = CommunityPostModel(
          alert: true,
          communityId: communityId,
          userId: userId,
          alertMsg: DateTime.now().toString().substring(0, 10),
          image: '',
          time: '');
      await CommunityPostDbFunctions().createPost(dates);
    }

    //adding alert to the community chat list

    final values = CommunityPostModel(
        alert: true,
        communityId: communityId,
        userId: userId,
        alertMsg:
            '${await UserDbFunctions().getUsername(UserDbFunctions().userId)} removed ${await UserDbFunctions().getUsername(userId)}'
                .titleCase,
        image: '',
        time: '');
    await CommunityPostDbFunctions().createPost(values);

    //removing the community name to user db for searching
    await FirebaseFirestore.instance
        .collection(FirebaseConstants.userDb)
        .doc(userId)
        .update({
      FirebaseConstants.fieldCommunitiyNames:
          FieldValue.arrayRemove([await getCommunityName(communityId)])
    });
  }

  @override
  Future<void> userTyping(String userId, String communityId) async {
    //finding the username of the typing user
    final userData = await FirebaseFirestore.instance
        .collection(FirebaseConstants.userDb)
        .doc(userId)
        .get();
    log(userData[FirebaseConstants.fieldRealname]);

    //adding the name to typing field of community db
    FirebaseFirestore.instance
        .collection(FirebaseConstants.communityDb)
        .doc(communityId)
        .update({
      FirebaseConstants.fieldCommunityTyping:
          userData[FirebaseConstants.fieldRealname]
    });

    //removing the typing user after 3 seconds
    Timer(const Duration(seconds: 3), () {
      FirebaseFirestore.instance
          .collection(FirebaseConstants.communityDb)
          .doc(communityId)
          .update({FirebaseConstants.fieldCommunityTyping: ''});
    });
  }

  //function to get the name of the community using id for searching
  @override
  Future<String> getCommunityName(String communityId) async {
    final ref = await FirebaseFirestore.instance
        .collection(FirebaseConstants.communityDb)
        .doc(communityId)
        .get();
    return ref[FirebaseConstants.fieldCommunityName];
  }
}
