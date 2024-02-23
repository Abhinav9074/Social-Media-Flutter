import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyFollowersPage extends StatelessWidget {
  const MyFollowersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Followers',
          style: MyTextStyle.commonButtonText,
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
               .collection(FirebaseConstants.userDb)
               .doc(UserDbFunctions().userId)
               .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return ListView.builder(
                  itemCount:
                      snapshot.data![FirebaseConstants.fieldFollowers].length,
                  itemBuilder: (context, index) {
                    final data =
                        snapshot.data![FirebaseConstants.fieldFollowers][index];
                    return _mutualUserListTile(
                        userId: data,
                        followingList:
                            snapshot.data![FirebaseConstants.fieldFollowing]);
                  });
            }
          }),
    ));
  }

//individual user tile
  Widget _mutualUserListTile(
      {required String userId, required List<dynamic> followingList}) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(FirebaseConstants.userDb)
            .doc(userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage:
                    NetworkImage(snapshot.data![FirebaseConstants.fieldImage]),
              ),
              title: Text(
                snapshot.data![FirebaseConstants.fieldRealname],
                style: MyTextStyle.commonButtonText,
              ),
              trailing:
                  followButton(userId: userId, followingList: followingList),
            );
          }
        });
  }

  //follow button
  Widget followButton(
      {required String userId, required List<dynamic> followingList}) {
    if (followingList.contains(userId)) {
      return ElevatedButton.icon(
        onPressed: () async {
          await UserDbFunctions().unFollowUser(userId);
        },
        icon: const FaIcon(
          FontAwesomeIcons.check,
          size: 15,
          color: Colors.white,
        ),
        label: const Text(
          'FOLLOWING',
          style: MyTextStyle.commonDescriptionTextWhite,
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 0, 76, 255)),
      );
    } else {
      return ElevatedButton.icon(
        onPressed: () async {
          await UserDbFunctions().followUser(userId);
        },
        icon: const FaIcon(
          FontAwesomeIcons.userPlus,
          size: 15,
          color: Colors.white,
        ),
        label: const Text(
          'FOLLOW BACK',
          style: MyTextStyle.commonDescriptionTextWhite,
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 0, 76, 255)),
      );
    }
  }
}
