import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

class CommunityPosts extends StatelessWidget {
  final String postId;

  const CommunityPosts({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(FirebaseConstants.communityPostDb)
            .doc(postId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            //if alert
            if (snapshot.data![FirebaseConstants.fieldCommunityPostIsAltert] ==
                true) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                        child: Text(
                          snapshot.data![
                              FirebaseConstants.fieldCommunityPostAlertMsg],
                          style: MyTextStyle.greyHeadingTextSmall,
                        ),
                      ),
                    ),
                  ),
                ],
              );

              //if image attached message
            } else if (snapshot
                    .data![FirebaseConstants.fieldCommunityPostImage] !=
                '') {
              //if the logged in user is sending the message
              if (snapshot.data![FirebaseConstants.fieldCommunityPostUserId] ==
                  UserDbFunctions().userId) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 2, 0, 2),

                      //wrapping container
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 195, 235, 165),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //image container
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                height: 200,
                                width: 300,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(snapshot.data![
                                            FirebaseConstants
                                                .fieldCommunityPostImage]),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ),

                            //message container
                            Container(
                              width: 300,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: snapshot.data![FirebaseConstants
                                          .fieldCommunityPostMessage] ==
                                      ''
                                  ? const SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        snapshot.data![FirebaseConstants
                                            .fieldCommunityPostMessage],
                                        style: MyTextStyle.descriptionText,
                                      ),
                                    ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8,bottom: 10),
                              child: Text(
                                snapshot.data![
                                    FirebaseConstants.fieldCommunityPostTime],
                                style: MyTextStyle.greyHeadingTextSmall,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                //if other user is sending the message
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection(FirebaseConstants.userDb)
                            .doc(snapshot.data![
                                FirebaseConstants.fieldCommunityPostUserId])
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const SizedBox();
                          } else {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(3, 0, 2, 0),
                              child: CircleAvatar(
                                radius: 15,
                                backgroundImage: NetworkImage(snapshot
                                    .data![FirebaseConstants.fieldImage]),
                              ),
                            );
                          }
                        }),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 2, 0, 2),

                      //wrapping container
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection(FirebaseConstants.userDb)
                                    .doc(snapshot.data![FirebaseConstants
                                        .fieldCommunityPostUserId])
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const SizedBox();
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 3, 0, 0),
                                      child: Text(
                                        '${snapshot.data![FirebaseConstants.fieldRealname]}'
                                            .titleCase,
                                        style: MyTextStyle.commonButtonTextRed,
                                      ),
                                    );
                                  }
                                }),

                            //image container
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                height: 200,
                                width: 300,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(snapshot.data![
                                            FirebaseConstants
                                                .fieldCommunityPostImage]),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ),

                            //message container
                            Container(
                              width: 300,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: snapshot.data![FirebaseConstants
                                          .fieldCommunityPostMessage] ==
                                      ''
                                  ? const SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        snapshot.data![FirebaseConstants
                                            .fieldCommunityPostMessage],
                                        style: MyTextStyle.descriptionText,
                                      ),
                                    ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8,bottom: 10),
                              child: Text(
                                snapshot.data![
                                    FirebaseConstants.fieldCommunityPostTime],
                                style: MyTextStyle.greyHeadingTextSmall,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }

              //if text only message
            } else {
              //if the logged in user is sending the message
              if (snapshot.data![FirebaseConstants.fieldCommunityPostUserId] ==
                  UserDbFunctions().userId) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 195, 235, 165),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data![FirebaseConstants
                                        .fieldCommunityPostMessage],
                                    style: MyTextStyle.descriptionText,
                                  ),
                                  Text(
                                    snapshot.data![FirebaseConstants
                                        .fieldCommunityPostTime],
                                    style: MyTextStyle.greyHeadingTextSmall,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                // if other user is sending the message
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection(FirebaseConstants.userDb)
                            .doc(snapshot.data![
                                FirebaseConstants.fieldCommunityPostUserId])
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const SizedBox();
                          } else {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(3, 8, 2, 0),
                              child: CircleAvatar(
                                radius: 15,
                                backgroundImage: NetworkImage(snapshot
                                    .data![FirebaseConstants.fieldImage]),
                              ),
                            );
                          }
                        }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection(FirebaseConstants.userDb)
                                          .doc(snapshot.data![FirebaseConstants
                                              .fieldCommunityPostUserId])
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return const SizedBox();
                                        } else {
                                          return Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                2, 0, 0, 0),
                                            child: Text(
                                              '${snapshot.data![FirebaseConstants.fieldRealname]}'
                                                  .titleCase,
                                              style: MyTextStyle
                                                  .commonButtonTextRed,
                                            ),
                                          );
                                        }
                                      }),
                                  Text(
                                    snapshot.data![FirebaseConstants
                                        .fieldCommunityPostMessage],
                                    style: MyTextStyle.descriptionText,
                                  ),
                                  Text(
                                    snapshot.data![FirebaseConstants
                                        .fieldCommunityPostTime],
                                    style: MyTextStyle.greyHeadingTextSmall,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            }
          }
        });
  }
}
