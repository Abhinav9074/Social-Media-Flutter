import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/application/bloc/other_profile_bloc/other_profile_bloc.dart';
import 'package:connected/application/bloc/other_profile_bloc/other_profile_event.dart';
import 'package:connected/application/bloc/user_search_bloc/user_search_bloc.dart';
import 'package:connected/application/bloc/user_search_bloc/user_search_state.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/domain/streams/searched_users.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/profile/screens/other_profile_test.dart';
import 'package:connected/presentation/screens/profile/screens/other_profile_view.dart';
import 'package:connected/presentation/screens/profile/screens/self_profile_test.dart';
import 'package:connected/presentation/screens/profile/screens/self_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:recase/recase.dart';

class SearchedUsers extends StatelessWidget {
  const SearchedUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserSearchBloc, UserSearchState>(
      builder: (context, state) {
        if (state is UserResultState) {
          return StreamBuilder(
              stream: userSearchStream(state.searchValue),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return  Lottie.asset('assets/lottie/no_user.json',height: 100,width: 100,frameRate: const FrameRate(90));
                }
                if (!snapshot.hasData) {
                  return  Lottie.asset('assets/lottie/no_user.json',height: 100,width: 100,frameRate: const FrameRate(90));
                }if(snapshot.data!.isEmpty){
                  return  Lottie.asset('assets/lottie/no_user.json',height: 100,width: 100,frameRate: const FrameRate(90));
                }
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final data = snapshot.data![index];
                      return InkWell(
                        onTap: () {
                          log(data['id']);
                          //notifying the bloc to check the following state of the user in the next page
                          BlocProvider.of<OtherProfileBloc>(context).add(
                              OtherProfileRedirectEvent(otherUserId: data['id']));

                          //if the logged in user is clikcing
                          if (data['id'] == UserDbFunctions().userId) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => const ProfileScreen()));
                          } else {
                            //for other users
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => OtherProfileScreen(
                                      userId: data['id'],
                                      index: index,
                                    )));
                          }
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                data[FirebaseConstants.fieldImage]),
                          ),
                          title: Text('${data[FirebaseConstants.fieldRealname]}'.titleCase,style: MyTextStyle.commonButtonText,),
                          subtitle: Text(data[FirebaseConstants.fieldusername],style: MyTextStyle.greyHeadingTextSmall,),
                        ),
                      );
                    });
              });
        } else if (state is NoSearchValueState) {
          return  Lottie.asset('assets/lottie/no_user.json',height: 100,width: 100,frameRate: const FrameRate(90));
        } else {
          return  Lottie.asset('assets/lottie/no_user.json',height: 100,width: 100,frameRate: const FrameRate(90));
        }
      },
    );
  }
}
