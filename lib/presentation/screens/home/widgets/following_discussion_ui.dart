
import 'package:connected/application/bloc/like_bloc.dart/like_bloc.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/streams/following_discussion.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/home/widgets/heading_image_widget.dart';
import 'package:connected/presentation/screens/home/widgets/social_tab.dart';
import 'package:connected/presentation/screens/home/widgets/user_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class FollowingDiscussionUi extends StatelessWidget {
  const FollowingDiscussionUi({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: follwoingDiscussionList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator()
            );
          }else if(snapshot.data!.isEmpty){
           return Column(
            mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Lottie.asset('assets/lottie/no_follow.json'),
               const Text('Follow More to See More',style: MyTextStyle.descriptionText,)
             ],
           );
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final data = snapshot.data![index];
                  return BlocProvider(
                    create: (context) => LikeBloc(),
                    child: Container(
                      decoration:
                          BoxDecoration(border: Border.all(width: 0.02)),
                      child: Column(
                        children: [
                          UserDeatilsTile(
                            userId:
                                data[FirebaseConstants.fieldDiscussionUserId],
                                time: data[FirebaseConstants.fieldDiscussionCreatedTime],
                                index: index,
                                edited : data[FirebaseConstants.fieldDiscussionEdited],
                                discussionId: data['id'],
                          ),
                          HeadingAndImageWidget(
                              isImage: true,
                              isText: false,
                              title: data[
                                  FirebaseConstants.fieldDiscussionTitle],
                              image: data[
                                  FirebaseConstants.fieldDiscussionImage],
                              text: 'some sample text',
                              index: index,
                              discssionId: data['id'],
                              description: data[FirebaseConstants.fieldDiscussionDescription],),
                          SocialTab(
                                like: data[FirebaseConstants
                                            .fieldDiscussionLikes]
                                        .length ??
                                    0,
                                discussions: data[FirebaseConstants
                                        .fieldDiscussionContribution]
                                    .length,
                                discussionId: data['id'],
                                title: data[FirebaseConstants.fieldDiscussionTitle],
                                contributions: data[FirebaseConstants.fieldDiscussionContribution].length??0,
                              )
                        ],
                      ),
                    ),
                  );
                });
          }
        });
  }
}
