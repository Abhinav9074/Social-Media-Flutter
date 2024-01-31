import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/application/bloc/like_bloc.dart/like_bloc.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/presentation/screens/home/widgets/heading_image_widget.dart';
import 'package:connected/presentation/screens/home/widgets/social_tab.dart';
import 'package:connected/presentation/screens/profile/widgets/discussion_edit_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelfDiscussionView extends StatelessWidget {
  final String discussionId;

  const SelfDiscussionView({super.key, required this.discussionId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(FirebaseConstants.discussionDb)
              .doc(discussionId)
              .snapshots(),
          builder: (context, snapshot) {
            final data = snapshot.data;
            if(!snapshot.hasData){
              return const Center(child: CircularProgressIndicator(),);
            }else{
              return Container(
              decoration: BoxDecoration(border: Border.all(width: 0.02)),
              child: Column(
                children: [
                  DiscussionEditTab(
                    userId: data![FirebaseConstants.fieldDiscussionUserId],
                    time: data[FirebaseConstants.fieldDiscussionCreatedTime],
                    index: 0,
                    discussionId: discussionId,
                  ),
                  HeadingAndImageWidget(
                    isImage: true,
                    isText: false,
                    title: data[FirebaseConstants.fieldDiscussionTitle],
                    image: data[FirebaseConstants.fieldDiscussionImage],
                    text: 'some sample text',
                    index: 0,
                    discssionId: data.id,
                    description:
                        data[FirebaseConstants.fieldDiscussionDescription],
                  ),
                  BlocProvider(
                    create: (context) => LikeBloc(),
                    child: SocialTab(
                      like:
                          data[FirebaseConstants.fieldDiscussionLikes].length ??
                              0,
                      discussions:
                          data[FirebaseConstants.fieldDiscussionContribution]
                              .length,
                      discussionId: data.id,
                      title: data[FirebaseConstants.fieldDiscussionTitle],
                      contributions:
                          data[FirebaseConstants.fieldDiscussionContribution]
                                  .length ??
                              0,
                    ),
                  )
                ],
              ),
            );
            }
          }),
    );
  }
}
