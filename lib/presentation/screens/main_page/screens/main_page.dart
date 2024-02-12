// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/application/bloc/ai_generate_bloc/ai_generate_bloc.dart';
import 'package:connected/application/bloc/user_access_bloc/user_access_bloc.dart';
import 'package:connected/application/bloc/user_access_bloc/user_access_event.dart';
import 'package:connected/application/bloc/user_access_bloc/user_access_state.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/common/functions/logout/logout.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/presentation/core/snackbars/common_snackbar.dart';
import 'package:connected/presentation/screens/all_post/screens/all_post_screen.dart';
import 'package:connected/presentation/screens/chats/screens/chat_screen.dart';
import 'package:connected/presentation/screens/community/screens/community_screen.dart';
import 'package:connected/presentation/screens/create_discussion/screens/create_discussion_screen.dart';
import 'package:connected/presentation/screens/home/screens/home_screen.dart';
import 'package:connected/presentation/screens/login/screens/login_screen.dart';
import 'package:connected/presentation/widgets/app_bar.dart';
import 'package:connected/presentation/widgets/drawer_items.dart';
import 'package:connected/presentation/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

late BuildContext mainPageContext;

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    mainPageContext = context;
    final pages = [
      const HomeScreen(),
      const CommunityScreen(),
       BlocProvider(
        create: (context) => AiGenerateBloc(),
        child: const CreateDiscussion(),
      ),
      const ChatScreen(),
      const AllPostsScreen()
    ];
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(FirebaseConstants.userDb)
            .doc(UserDbFunctions().userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return BlocListener<UserAccessBloc, UserAccessState>(
              listener: (context, state) async {
                if (state is UserBlockedState) {
                  //logging out if the user is blocked
                  await logOut();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (ctx) => const LoginScreen()),
                      (route) => false);
                  screenChangeNotifier.value = 0;
                  AllSnackBars.commonSnackbar(
                      context: context,
                      title: 'Error',
                      content: 'Your Account Is Blocked',
                      bg: Colors.red);
                }
              },
              child: ValueListenableBuilder(
                valueListenable: screenChangeNotifier,
                builder: (context, int index, _) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.data![FirebaseConstants.fieldUserBlocked] ==
                        true) {
                      BlocProvider.of<UserAccessBloc>(context)
                          .add(CheckUserAccess());
                    }
                    return SafeArea(
                      child: Scaffold(
                        appBar: const CustomAppBar(),
                        drawer: const SafeArea(
                          child: Drawer(
                            child: DrawerItems(),
                          ),
                        ),
                        body: pages[index],
                        bottomNavigationBar: const BottomNavigationDrawer(),
                      ),
                    );
                  }
                },
              ),
            );
          }
        });
  }
}
