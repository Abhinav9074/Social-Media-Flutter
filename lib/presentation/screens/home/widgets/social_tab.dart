import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/application/bloc/like_bloc.dart/like_bloc.dart';
import 'package:connected/application/bloc/like_bloc.dart/like_event.dart';
import 'package:connected/application/bloc/like_bloc.dart/like_state.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';

import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/chats/widgets/follwoing_follower_screen.dart';
import 'package:connected/presentation/screens/contribute_discussion/screens/contribute_discussion_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialTab extends StatelessWidget {
  final String title;
  final int like;
  final int contributions;
  final int discussions;
  final String discussionId;

  const SocialTab(
      {super.key,
      required this.like,
      required this.discussions,
      required this.discussionId,
      required this.title,
      required this.contributions});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(FirebaseConstants.discussionDb)
            .doc(discussionId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //like button
                        BlocBuilder<LikeBloc, LikeState>(
                          builder: (context, state) {
                            if (state is AddLikeState ||
                                snapshot.data!['likes']
                                    .contains(UserDbFunctions().userId)) {
                              return TextButton.icon(
                                  onPressed: () {
                                    BlocProvider.of<LikeBloc>(context).add(
                                        RemoveLikeEvent(
                                            discussionId: discussionId));
                                  },
                                  icon: const Icon(
                                    Icons.thumb_up,
                                    color: Color.fromARGB(255, 255, 3, 3),
                                  ),
                                  label: Text(
                                    '$like',
                                    style: MyTextStyle.commonButtonText,
                                    textScaler: TextScaler.noScaling,
                                  ));
                            } else {
                              return TextButton.icon(
                                  onPressed: () {
                                    BlocProvider.of<LikeBloc>(context).add(
                                        AddLikeEvent(
                                            discussionId: discussionId));
                                  },
                                  icon: const Icon(
                                    Icons.thumb_up,
                                    color: Color.fromARGB(255, 98, 97, 97),
                                  ),
                                  label: Text(
                                    '${snapshot.data!['likes'].length}',
                                    style: MyTextStyle.commonButtonText,
                                    textScaler: TextScaler.noScaling,
                                  ));
                            }
                          },
                        ),

                        //discussion icon
                        TextButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => ContributeToDiscussionPage(
                                      title: title,
                                      discussionId: discussionId,
                                      count: discussions)));
                            },
                            icon: const Icon(
                              Icons.comment_rounded,
                              color: Color.fromARGB(255, 98, 97, 97),
                            ),
                            label: Text(
                              '$discussions',
                              style: MyTextStyle.commonButtonText,
                              textScaler: TextScaler.noScaling,
                            )),

                        //share button
                        TextButton.icon(
                            onPressed: () {
                              showBottomSheet(
                                  constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.width),
                                  context: context,
                                  builder: (context) {
                                    return FollowingAndFollowers(
                                      discussionId: discussionId,
                                      discussionName: snapshot.data![
                                          FirebaseConstants
                                              .fieldDiscussionTitle],
                                    );
                                  });
                            },
                            icon: const Icon(
                              Icons.share,
                              color: Color.fromARGB(255, 98, 97, 97),
                            ),
                            label: const Text(
                              'share',
                              style: MyTextStyle.commonButtonText,
                              textScaler: TextScaler.noScaling,
                            )),

                        //save button
                        TextButton.icon(
                            onPressed: () async {
                              await UserDbFunctions()
                                  .saveDiscussion(discussionId);
                            },
                            icon: const Icon(
                              Icons.save,
                              color: Color.fromARGB(255, 98, 97, 97),
                            ),
                            label: const Text(
                              'save',
                              style: MyTextStyle.commonButtonText,
                              textScaler: TextScaler.noScaling,
                            )),
                      ],
                    ),
                  )),
            );
          }
        });
  }
}
