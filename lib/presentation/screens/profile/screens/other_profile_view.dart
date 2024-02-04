// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/application/bloc/other_profile_bloc/other_profile_bloc.dart';
import 'package:connected/application/bloc/other_profile_bloc/other_profile_event.dart';
import 'package:connected/application/bloc/other_profile_bloc/other_profile_state.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/map_view/screens/map_view_screen.dart';
import 'package:connected/presentation/screens/profile/widgets/discussion_tab.dart';
import 'package:connected/presentation/screens/profile/widgets/profile_pic_widget.dart';
import 'package:connected/presentation/screens/profile/widgets/user_basic_details.dart';
import 'package:connected/presentation/screens/report/screens/user_report_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OtherProfileScreen extends StatelessWidget {
  final String userId;
  final int index;

  const OtherProfileScreen(
      {super.key, required this.userId, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
              surfaceTintColor: Colors.black,
              itemBuilder: (context) => [
                     PopupMenuItem(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>UserReportScreen(userId:userId)));
                      },
                      value: 2,
                      child: const Row(
                        children: [
                          Icon(Icons.report),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Report")
                        ],
                      ),
                    )
                  ])
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(FirebaseConstants.userDb)
              .doc(userId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //style wrapper
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 30,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        //profile pic
                        ProfilePicture(
                            image:
                                snapshot.data![FirebaseConstants.fieldImage]),
    
                        const SizedBox(
                          height: 10,
                        ),
    
                        //follow logic button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BlocBuilder<OtherProfileBloc, OtherProfileState>(
                              builder: (context, state) {
                                if (state is FollowingState) {
                                  return ElevatedButton.icon(
                                      onPressed: () async {
                                        await UserDbFunctions()
                                            .unFollowUser(userId);
                                        BlocProvider.of<OtherProfileBloc>(
                                                context)
                                            .add(OtherProfileRedirectEvent(
                                                otherUserId: userId));
                                      },
                                      icon: const FaIcon(
                                        FontAwesomeIcons.check,
                                        size: 15,
                                      ),
                                      label: const Text('Following'));
                                } else if (state is FollowBackState) {
                                  return ElevatedButton.icon(
                                      onPressed: () async {
                                        await UserDbFunctions()
                                            .followUser(userId);
                                        BlocProvider.of<OtherProfileBloc>(
                                                context)
                                            .add(OtherProfileRedirectEvent(
                                                otherUserId: userId));
                                      },
                                      icon: const FaIcon(
                                        FontAwesomeIcons.userPlus,
                                        size: 15,
                                      ),
                                      label: const Text('Follow Back'));
                                } else {
                                  return ElevatedButton.icon(
                                      onPressed: () async {
                                        await UserDbFunctions()
                                            .followUser(userId);
                                        BlocProvider.of<OtherProfileBloc>(
                                                context)
                                            .add(OtherProfileRedirectEvent(
                                                otherUserId: userId));
                                      },
                                      icon: const FaIcon(
                                        FontAwesomeIcons.userPlus,
                                        size: 15,
                                      ),
                                      label: const Text('Follow'));
                                }
                              },
                            )
                          ],
                        ),

                        IconButton(onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>MapViewScreen(userId: userId)));
                        }, icon: const Icon(Icons.location_on)),
    
                        //user basic details
    
                        UserBasicDeatils(
                            bio: 'A person with no desire',
                            name: snapshot
                                .data![FirebaseConstants.fieldRealname],
                            location: 'Calicut , India',
                            following:
                                '${snapshot.data![FirebaseConstants.fieldFollowing] == null ? 0 : snapshot.data![FirebaseConstants.fieldFollowing].length}',
                            followers:
                                '${snapshot.data![FirebaseConstants.fieldFollowers] == null ? 0 : snapshot.data![FirebaseConstants.fieldFollowers].length}',
                            count:
                                '${snapshot.data![FirebaseConstants.fieldDiscussions] == null ? 0 : snapshot.data![FirebaseConstants.fieldDiscussions].length}'),
    
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
    
                  const SizedBox(
                    height: 20,
                  ),
    
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                    child: Text(
                      'All Discussions',
                      style: MyTextStyle.discussionHeadingText,
                    ),
                  ),
    
                  //all discussions
    
                  Expanded(
                      child: DiscussionTab(
                    count:
                        snapshot.data![FirebaseConstants.fieldDiscussions] ==
                                null
                            ? 0
                            : snapshot
                                .data![FirebaseConstants.fieldDiscussions]
                                .length,
                                id: snapshot.data!.id,
                  ))
                ],
              ),
            );
          }),
    );
  }
}
