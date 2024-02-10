import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/application/bloc/community_creation_bloc/community_creation_bloc.dart';
import 'package:connected/application/bloc/community_name_bloc/community_name_bloc.dart';
import 'package:connected/application/bloc/community_search_bloc/community_search_bloc.dart';
import 'package:connected/application/bloc/community_search_bloc/community_search_state.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/community/screens/create_community.dart';
import 'package:connected/presentation/screens/community/widgets/community_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class MyCommunity extends StatelessWidget {
  const MyCommunity({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunitySearchBloc, CommunitySearchState>(
      builder: (context, state) {
        if (state is CommunitySearchedState) {
          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(FirebaseConstants.userDb)
                  .doc(UserDbFunctions().userId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot
                    .data![FirebaseConstants.fieldCommunities].length==0) {
                      
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/lottie/no_community.json'),
                      const Text(
                        'Join Your First Community',
                        style: MyTextStyle.descriptionText,
                      )
                    ],
                  );
                } else {
                  return Stack(
                    children: [
                      ListView.builder(
                          itemCount: snapshot
                              .data![FirebaseConstants.fieldCommunities].length,
                          itemBuilder: (ctx, index) {
                            final data = snapshot
                                    .data![FirebaseConstants.fieldCommunities]
                                [index];
                            final communityName = snapshot.data![
                                FirebaseConstants.fieldCommunitiyNames][index];
                            if (communityName.contains(state.keyword)) {
                              return CommunityTab(communityId: data);
                            } else {
                              return const SizedBox();
                            }
                          }),
                      Positioned(
                          bottom: 10,
                          right: 10,
                          child: FloatingActionButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => BlocProvider(

                                      //provide bloc for community name checking and for all other community operations
                                      create: (context) => CommunityNameBloc(),
                                      child: BlocProvider(
                                        create: (context) =>
                                            CommunityCreationBloc(),
                                        child: const CreateCommunity(),
                                      ))));
                            },
                            backgroundColor:
                                const Color.fromARGB(255, 216, 215, 215),
                            shape: const CircleBorder(),
                            child: const Icon(
                              Icons.add,
                              color: Colors.grey,
                            ),
                          ))
                    ],
                  );
                }
              });
        } else {
          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(FirebaseConstants.userDb)
                  .doc(UserDbFunctions().userId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }else if (snapshot
                    .data![FirebaseConstants.fieldCommunities].length==0) {
                      
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/lottie/no_community.json'),
                      const Text(
                        'Join Your First Community',
                        style: MyTextStyle.descriptionText,
                      )
                    ],
                  );
                } else {
                  return Stack(
                    children: [
                      ListView.builder(
                          itemCount: snapshot
                              .data![FirebaseConstants.fieldCommunities].length,
                          itemBuilder: (ctx, index) {
                            final data = snapshot
                                    .data![FirebaseConstants.fieldCommunities]
                                [index];
                            return CommunityTab(communityId: data);
                          }),
                      // Positioned(
                      //     bottom: 10,
                      //     right: 10,
                      //     child: FloatingActionButton(
                      //       onPressed: () {
                      //         Navigator.of(context).push(MaterialPageRoute(
                      //             builder: (context) => BlocProvider(

                      //                 //provide bloc for community name checking and for all other community operations
                      //                 create: (context) => CommunityNameBloc(),
                      //                 child: BlocProvider(
                      //                   create: (context) =>
                      //                       CommunityCreationBloc(),
                      //                   child: const CreateCommunity(),
                      //                 ))));
                      //       },
                      //       backgroundColor:
                      //           const Color.fromARGB(255, 216, 215, 215),
                      //       shape: const CircleBorder(),
                      //       child: const Icon(
                      //         Icons.add,
                      //         color: Colors.grey,
                      //       ),
                      //     ))
                    ],
                  );
                }
              });
        }
      },
    );
  }
}
