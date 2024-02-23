// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/application/bloc/user_search_bloc/user_search_bloc.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/presentation/core/media_query/media_query.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/notification/screens/notification_screen.dart';
import 'package:connected/presentation/screens/profile/screens/self_profile_test.dart';
import 'package:connected/presentation/screens/search_page/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQueryCustom.appBarHeight(context),
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: const Icon(Icons.menu))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) =>  BlocProvider(
                                  create: (context) => UserSearchBloc(),
                                  child: const SearchScreen(),
                                )));
                      },
                      icon: const Icon(Icons.search)),
                  const SizedBox(
                    width: 20,
                  ),
                  Stack(
                    children: [
                      IconButton(
                        onPressed: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const NotificationScreen()));
                          //clearing the notification count
                          await UserDbFunctions().clearNotificationCount();
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.bell,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection(FirebaseConstants.userDb)
                              .doc(UserDbFunctions().userId)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const SizedBox();
                            } else if (snapshot.data![
                                    FirebaseConstants.fieldNotificationCount] >
                                0) {
                              return Positioned(
                                right: 6,
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.red,
                                  child: Text(
                                    snapshot.data![FirebaseConstants
                                            .fieldNotificationCount]
                                        .toString(),
                                    style: MyTextStyle.commonButtonTextWhite,
                                  ),
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          })
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => const ProfileScreen()));
                      },
                      icon: const CircleAvatar(
                        child: Icon(Icons.account_circle),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 100);
}
