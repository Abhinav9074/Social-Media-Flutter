import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/application/bloc/location_bloc/location_bloc.dart';
import 'package:connected/application/bloc/profile_switch_bloc/profile_switch_bloc.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/followers/screens/followers_list_screen.dart';
import 'package:connected/presentation/screens/followers/screens/following_list_screen.dart';
import 'package:connected/presentation/screens/premium/screens/subscribe_to_premium.dart';
import 'package:connected/presentation/screens/profile/widgets/discussion_tab.dart';
import 'package:connected/presentation/screens/profile/widgets/follow_tab.dart';
import 'package:connected/presentation/screens/profile/widgets/saved_discussion_tab.dart';
import 'package:connected/presentation/screens/profile_edit/screens/profile_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:recase/recase.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                    .doc(UserDbFunctions().userId)
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
                                      //back icon
                                      IconButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          icon: const Icon(
                                            Icons.arrow_back,
                                            color: Colors.white,
                                          )),

                                      //edit profile and premium
                                      Row(
                                        children: [
                                          StreamBuilder(
                                              stream: FirebaseFirestore.instance
                                                  .collection(
                                                      FirebaseConstants.userDb)
                                                  .doc(UserDbFunctions().userId)
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                if (!snapshot.hasData) {
                                                  return const CircularProgressIndicator();
                                                } else {
                                                  return PopupMenuButton(
                                                      iconColor: Colors.white,
                                                      surfaceTintColor:
                                                          const Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                      itemBuilder:
                                                          (context) => [
                                                                PopupMenuItem(
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .push(MaterialPageRoute(
                                                                            builder: (ctx) => BlocProvider(
                                                                                  create: (context) => LocationBloc(),
                                                                                  child: BlocProvider(
                                                                                    create: (context) => ProfileSwitchBloc(),
                                                                                    child: EditProfileScreen(),
                                                                                  ),
                                                                                )));
                                                                  },
                                                                  value: 1,
                                                                  child:
                                                                      const Row(
                                                                    children: [
                                                                      Icon(Icons
                                                                          .edit),
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                        "Edit Profile",
                                                                        style: MyTextStyle
                                                                            .commonButtonText,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                snapshot.data![FirebaseConstants
                                                                            .fieldPremiumUser] ==
                                                                        false
                                                                    ? PopupMenuItem(
                                                                        onTap:
                                                                            () {
                                                                          if (snapshot.data![FirebaseConstants.fieldPremiumUser] ==
                                                                              false) {
                                                                            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const SubscribeToPremiumPage()));
                                                                          }
                                                                        },
                                                                        value:
                                                                            2,
                                                                        child:
                                                                            const Row(
                                                                          children: [
                                                                            FaIcon(
                                                                              FontAwesomeIcons.crown,
                                                                              color: Color.fromARGB(255, 184, 170, 44),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 10,
                                                                            ),
                                                                            Text(
                                                                              "My Activity",
                                                                              style: MyTextStyle.commonButtonText,
                                                                            )
                                                                          ],
                                                                        ),
                                                                      )
                                                                    : const PopupMenuItem(
                                                                        child:
                                                                            SizedBox())
                                                              ]);
                                                }
                                              })
                                        ],
                                      )
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
                                              .length,
                                          context: context),

                                      const SizedBox(
                                        height: 20,
                                      ),
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
                          child: DefaultTabController(
                            length: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TabBar(
                                    onTap: (value) {},
                                    indicatorColor: Colors.white,
                                    dividerHeight: 0,
                                    tabAlignment: TabAlignment.fill,
                                    labelStyle:
                                        MyTextStyle.greyHeadingTextSmall,
                                    tabs: const [
                                      Tab(
                                        text: 'My Discussions',
                                        iconMargin:
                                            EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      ),
                                      Tab(
                                        text: 'Saved',
                                      ),
                                    ]),
                                Expanded(
                                    child: TabBarView(children: [
                                  DiscussionTab(
                                    count: snapshot.data![FirebaseConstants
                                                .fieldDiscussions] ==
                                            null
                                        ? 0
                                        : snapshot
                                            .data![FirebaseConstants
                                                .fieldDiscussions]
                                            .length,
                                    id: snapshot.data!.id,
                                  ),
                                  SavedDiscussionTab(
                                      id: UserDbFunctions().userId)
                                ])),
                              ],
                            ),
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
      required int discussions,
      required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>const MyFollowingPage()));
            },
            child: FollowTab(action: 'Following', count: following.toString())),
          const SizedBox(
            width: 40,
          ),
          InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) =>  const MyFollowersPage()));
              },
              child:
                  FollowTab(action: 'Followers', count: followers.toString())),
          const SizedBox(
            width: 40,
          ),
          FollowTab(action: 'Discussions', count: discussions.toString()),
        ],
      ),
    );
  }
}
