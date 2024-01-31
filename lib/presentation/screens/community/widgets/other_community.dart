import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/application/bloc/community_join_bloc/community_join_bloc.dart';
import 'package:connected/application/bloc/community_search_bloc/community_search_bloc.dart';
import 'package:connected/application/bloc/community_search_bloc/community_search_state.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/presentation/screens/community/widgets/other_community_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtherCommunities extends StatelessWidget {
  const OtherCommunities({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunitySearchBloc, CommunitySearchState>(
      builder: (context, state) {
        if (state is CommunitySearchedState) {
          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(FirebaseConstants.communityDb)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (ctx, index) {
                        final data = snapshot.data!.docs[index];
                        if (!data[FirebaseConstants.fieldCommunityMembers]
                                .contains(UserDbFunctions().userId) &&
                            data[FirebaseConstants.fieldCommunityName]
                                .contains(state.keyword)) {
                          return BlocProvider(
                            create: (context) => CommunityJoinBloc(),
                            child: OtherCommunityTab(
                              image:
                                  data[FirebaseConstants.fieldCommunityProfile],
                              communityName:
                                  data[FirebaseConstants.fieldCommunityName],
                              members:
                                  data[FirebaseConstants.fieldCommunityMembers]
                                      .length,
                              communityId: data.id,
                              requests: data[
                                  FirebaseConstants.fieldCommunityRequests],
                              communityType:
                                  data[FirebaseConstants.fieldCommunityPrivate],
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      });
                }
              });
        } else {
          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(FirebaseConstants.communityDb)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (ctx, index) {
                        final data = snapshot.data!.docs[index];
                        if (!data[FirebaseConstants.fieldCommunityMembers]
                            .contains(UserDbFunctions().userId)) {
                          return BlocProvider(
                            create: (context) => CommunityJoinBloc(),
                            child: OtherCommunityTab(
                              image:
                                  data[FirebaseConstants.fieldCommunityProfile],
                              communityName:
                                  data[FirebaseConstants.fieldCommunityName],
                              members:
                                  data[FirebaseConstants.fieldCommunityMembers]
                                      .length,
                              communityId: data.id,
                              requests: data[
                                  FirebaseConstants.fieldCommunityRequests],
                              communityType:
                                  data[FirebaseConstants.fieldCommunityPrivate],
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      });
                }
              });
        }
      },
    );
  }
}
