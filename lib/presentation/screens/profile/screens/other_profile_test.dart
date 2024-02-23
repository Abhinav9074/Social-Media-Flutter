// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/application/bloc/other_profile_bloc/other_profile_bloc.dart';
import 'package:connected/application/bloc/other_profile_bloc/other_profile_event.dart';
import 'package:connected/application/bloc/other_profile_bloc/other_profile_state.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/chats/screens/chat_inside_screen.dart';
import 'package:connected/presentation/screens/map_view/screens/map_view_screen.dart';
import 'package:connected/presentation/screens/profile/widgets/discussion_tab.dart';
import 'package:connected/presentation/screens/profile/widgets/follow_tab.dart';
import 'package:connected/presentation/screens/report/screens/user_report_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:recase/recase.dart';

class OtherProfileScreen extends StatelessWidget {
  final String userId;
  final int index;

  const OtherProfileScreen(
      {super.key, required this.userId, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
          ),
          SafeArea(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(FirebaseConstants.userDb)
                    .doc(userId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox();
                  } else {
                    return Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 2,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    snapshot
                                        .data![FirebaseConstants.fieldImage],
                                  ),
                                  fit: BoxFit.cover)),
                          child: Stack(children: [
                            Container(
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                    Color.fromARGB(169, 0, 0, 0),
                                    Color.fromARGB(168, 0, 0, 0),
                                    Color.fromARGB(255, 0, 0, 0),
                                  ])),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //APP BAR
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          icon: const Icon(
                                            Icons.arrow_back,
                                            color: Colors.white,
                                          )),
                                      Row(
                                        children: [
                                          snapshot.data![FirebaseConstants
                                                      .fieldAllowLocationView] ==
                                                  true
                                              ? IconButton(
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (ctx) =>
                                                                MapViewScreen(
                                                                    userId:
                                                                        userId)));
                                                  },
                                                  icon: Lottie.asset(
                                                      'assets/lottie/map.json',
                                                      height: 30,
                                                      width: 30),
                                                )
                                              : const SizedBox(),
                                          PopupMenuButton(
                                              iconColor: Colors.white,
                                              surfaceTintColor: Colors.black,
                                              itemBuilder: (context) => [
                                                    PopupMenuItem(
                                                      onTap: () {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder: (ctx) =>
                                                                    UserReportScreen(
                                                                        userId:
                                                                            userId)));
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
                                                  ]),
                                        ],
                                      ),
                                    ],
                                  ),

                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      //BASIC DETAILS
                                      userBasicDeatils(snapshot),

                                      //Follwoing and followers
                                      countDisplay(
                                          following: snapshot
                                              .data![FirebaseConstants
                                                  .fieldFollowing]
                                              .length,
                                          followers: snapshot
                                              .data![FirebaseConstants
                                                  .fieldFollowers]
                                              .length,
                                          discussions: snapshot
                                              .data![FirebaseConstants
                                                  .fieldDiscussions]
                                              .length),

                                      const SizedBox(
                                        height: 20,
                                      ),
                                      //follow of message button
                                      followOrMessageBtn(
                                          context: context, userId: userId)
                                    ],
                                  )
                                ],
                              ),
                            )
                          ]),
                        ),

                        //2nd Half
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.445,
                          color: const Color.fromARGB(255, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                                child: Text(
                                  'Discussions',
                                  style: MyTextStyle.commonButtonTextWhite,
                                ),
                              ),
                              Expanded(
                                  child: DiscussionTab(
                                count: snapshot.data![FirebaseConstants
                                            .fieldDiscussions] ==
                                        null
                                    ? 0
                                    : snapshot
                                        .data![
                                            FirebaseConstants.fieldDiscussions]
                                        .length,
                                id: snapshot.data!.id,
                              )),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }

  //user basic details
  Widget userBasicDeatils(final snapshot) {
    return Column(
      children: [
        snapshot.data![FirebaseConstants.fieldPremiumUser] == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    snapshot.data![FirebaseConstants.fieldRealname],
                    style: MyTextStyle.commonHeadingTextWhite,
                  ),
                  const Icon(
                    Icons.verified,
                    color: Colors.blue,
                  )
                ],
              )
            : Text(
                snapshot.data![FirebaseConstants.fieldRealname],
                style: MyTextStyle.commonHeadingTextWhite,
              ),
        snapshot.data![FirebaseConstants.fieldUserBio].isNotEmpty
            ? Text(
                '${snapshot.data![FirebaseConstants.fieldUserBio]}'.titleCase,
                style: MyTextStyle.greyHeadingTextSmall,
              )
            : const SizedBox(),
        snapshot.data![FirebaseConstants.fieldAddress].isNotEmpty
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 15,
                    color: Colors.red,
                  ),
                  Text(
                    '${snapshot.data![FirebaseConstants.fieldAddress]}'
                        .titleCase,
                    style: MyTextStyle.greyHeadingTextSmall,
                  )
                ],
              )
            : const SizedBox()
      ],
    );
  }

  //Follow , discussuon count
  Widget countDisplay(
      {required int following,
      required int followers,
      required int discussions}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FollowTab(action: 'Following', count: following.toString()),
          const SizedBox(
            width: 40,
          ),
          FollowTab(action: 'Followers', count: followers.toString()),
          const SizedBox(
            width: 40,
          ),
          FollowTab(action: 'Discussions', count: discussions.toString()),
        ],
      ),
    );
  }

  //follow or message button
  Widget followOrMessageBtn(
      {required BuildContext context, required String userId}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        followButton(),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => ChatInsideScreen(receiverId: userId)));
          },
          icon: const Icon(
            Icons.send,
            color: Colors.white,
          ),
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(0, 33, 149, 243),
              side: const BorderSide(color: Colors.white)),
          label: const Text(
            'MESSAGE',
            style: MyTextStyle.commonDescriptionTextWhite,
          ),
        ),
      ],
    );
  }

  //follow button
  Widget followButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocBuilder<OtherProfileBloc, OtherProfileState>(
          builder: (context, state) {
            if (state is OtherProfileLoadingState) {
              return Lottie.asset('assets/lottie/loading.json',height: 50,width:50);
            }else if (state is FollowingState) {
              return ElevatedButton.icon(
                onPressed: () async {
                  BlocProvider.of<OtherProfileBloc>(context)
                      .add(UnfollowUserEvent(unfollowUserId: userId));
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
            } else if (state is FollowBackState) {
              return ElevatedButton.icon(
                onPressed: () async {
                  BlocProvider.of<OtherProfileBloc>(context)
                      .add(FollowUserEvent(followedUserId: userId));
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
            }  else {
              return ElevatedButton.icon(
                onPressed: () async {
                 BlocProvider.of<OtherProfileBloc>(context)
                      .add(FollowUserEvent(followedUserId: userId));
                },
                icon: const FaIcon(
                  FontAwesomeIcons.userPlus,
                  size: 15,
                  color: Colors.white,
                ),
                label: const Text(
                  'FOLLOW',
                  style: MyTextStyle.commonDescriptionTextWhite,
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 76, 255)),
              );
            }
          },
        )
      ],
    );
  }
}
