import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/models/user_model/user_model.dart';
import 'package:connected/domain/shared_prefrences/login_logout/login_logout.dart';

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
}
