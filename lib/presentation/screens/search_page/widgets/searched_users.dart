import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/application/bloc/other_profile_bloc/other_profile_bloc.dart';
import 'package:connected/application/bloc/other_profile_bloc/other_profile_event.dart';
import 'package:connected/application/bloc/user_search_bloc/user_search_bloc.dart';
import 'package:connected/application/bloc/user_search_bloc/user_search_state.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/presentation/screens/profile/screens/other_profile_view.dart';
import 'package:connected/presentation/screens/profile/screens/self_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchedUsers extends StatelessWidget {
  const SearchedUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserSearchBloc, UserSearchState>(
      builder: (context, state) {
        if (state is UserResultState) {
          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(FirebaseConstants.userDb)
                  .where(FirebaseConstants.fieldRealname,
                      isGreaterThanOrEqualTo: state.searchValue)
                  .where(FirebaseConstants.fieldRealname,
                      isLessThan: '${state.searchValue}z')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Unknown Error Occured'));
                }
                if (!snapshot.hasData) {
                  return const Center(child: SizedBox());
                }
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final data = snapshot.data!.docs[index];
                      return InkWell(
                        onTap: () {
                          //notifying the bloc to check the following state of the user in the next page
                          BlocProvider.of<OtherProfileBloc>(context).add(
                              OtherProfileRedirectEvent(otherUserId: data.id));

                          //if the logged in user is clikcing
                          if (data.id == UserDbFunctions().userId) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => const ProfileScreen()));
                          } else {
                            //for other users
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => OtherProfileScreen(
                                      userId: data.id,
                                      index: index,
                                    )));
                          }
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                data[FirebaseConstants.fieldImage]),
                          ),
                          title: Text(data[FirebaseConstants.fieldRealname]),
                          subtitle: Text(data[FirebaseConstants.fieldusername]),
                        ),
                      );
                    });
              });
        } else if (state is NoSearchValueState) {
          return const Center(child: Text('No Data Found'));
        } else {
          return const Center(child: SizedBox());
        }
      },
    );
  }
}
