import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/community/screens/inside_community_screen.dart';
import 'package:flutter/material.dart';

class CommunityTab extends StatelessWidget {
  final String communityId;

  const CommunityTab({super.key, required this.communityId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(FirebaseConstants.communityDb)
            .doc(communityId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => CommunityInsideView(
                        image: snapshot
                            .data![FirebaseConstants.fieldCommunityProfile],
                        communityId: snapshot.data!.id)));
              },
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      snapshot.data![FirebaseConstants.fieldCommunityProfile]),
                  radius: 30,
                ),
                title: Text(
                  snapshot.data![FirebaseConstants.fieldCommunityName],
                  style: MyTextStyle.mediumHeadingText,
                ),
                subtitle: snapshot.data![FirebaseConstants.fieldCommunityTyping]
                        .isNotEmpty
                    ? Text(
                        '${snapshot.data![FirebaseConstants.fieldCommunityTyping]} is Typing...',
                        style: MyTextStyle.typingTextSmall,
                      )
                    : snapshot.data![FirebaseConstants.fieldCommunityMembers]
                                .length ==
                            1
                        ? Text(
                            '${snapshot.data![FirebaseConstants.fieldCommunityMembers].length} Member',
                            style: MyTextStyle.greyHeadingTextSmall,
                          )
                        : Text(
                            '${snapshot.data![FirebaseConstants.fieldCommunityMembers].length} Members',
                            style: MyTextStyle.greyHeadingTextSmall,
                          ),
              ),
            );
          }
        });
  }
}
