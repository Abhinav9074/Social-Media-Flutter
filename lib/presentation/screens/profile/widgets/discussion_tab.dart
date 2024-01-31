import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/presentation/core/media_query/media_query.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/profile/screens/self_discussion_view.dart';
import 'package:flutter/material.dart';

class DiscussionTab extends StatelessWidget {
  final int count;

  const DiscussionTab({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(FirebaseConstants.discussionDb)
            .where(FirebaseConstants.fieldDiscussionUserId,
                isEqualTo: UserDbFunctions().userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final data = snapshot.data!.docs[index];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => SelfDiscussionView(
                                discussionId: data.id,
                              )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 7, 15, 7),
                      child: Container(
                        height: MediaQueryCustom.discussionTabHeight(context),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: SizedBox(
                                      width: 250,
                                      child: Text(
                                        data[FirebaseConstants
                                            .fieldDiscussionTitle],
                                        style: MyTextStyle.commonButtonText,
                                        textScaler: TextScaler.noScaling,
                                      )),
                                ),
                                TextButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(Icons.thumb_up),
                                    label: Text(data[FirebaseConstants
                                            .fieldDiscussionLikes]
                                        .length
                                        .toString()))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
        });
  }
}
