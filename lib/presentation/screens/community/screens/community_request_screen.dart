import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/community_db/community_db_functions.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:flutter/material.dart';

class CommunityJoiningRequests extends StatelessWidget {
  final String communityId;
  const CommunityJoiningRequests({super.key, required this.communityId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pending Requests',
          style: MyTextStyle.commonButtonText,
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(FirebaseConstants.communityDb)
              .doc(communityId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return ListView.builder(
                  itemCount: snapshot
                      .data![FirebaseConstants.fieldCommunityRequests].length,
                  itemBuilder: (context, index) {
                    final data = snapshot
                        .data![FirebaseConstants.fieldCommunityRequests][index];
                    return StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection(FirebaseConstants.userDb)
                            .doc(data)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const SizedBox();
                          } else {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(snapshot
                                    .data![FirebaseConstants.fieldImage]),
                              ),
                              title: Text(
                                snapshot.data![FirebaseConstants.fieldRealname],
                                style: MyTextStyle.descriptionText,
                              ),
                              trailing: TextButton.icon(
                                  onPressed: () async {
                                    await CommunityDbFunctions()
                                        .joinPrivateCommunity(
                                            communityId, data);
                                  },
                                  icon: const Icon(Icons.add),
                                  label: const Text(
                                    'Accept',
                                    style: MyTextStyle.commonButtonText,
                                  )),
                            );
                          }
                        });
                  });
            }
          }),
    );
  }
}
