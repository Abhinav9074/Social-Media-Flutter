// ignore_for_file: use_build_context_synchronously

import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/home/widgets/following_discussion_ui.dart';
import 'package:connected/presentation/screens/home/widgets/interest_dissussion_ui.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
          body: Column(
            children: [
              TabBar(
                onTap: (value) {
                },
                indicatorColor: Colors.red,
                dividerHeight: 1,
                tabAlignment: TabAlignment.fill,
                labelStyle: MyTextStyle.greyHeadingTextSmall,
                tabs: const [
                  Tab(
                    text: 'My Interests',
                    iconMargin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  ),
                  Tab(
                    text: 'Following',
                  ),
                ]),
              const Expanded(
                child: TabBarView(children: [
                  InterestsDisscussionUi(),
                  FollowingDiscussionUi()
                ]),
              )
            ],
          )),
    );
  }
}
