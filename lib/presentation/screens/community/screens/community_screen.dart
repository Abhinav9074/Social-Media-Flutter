import 'dart:developer';

import 'package:connected/application/bloc/community_search_bloc/community_search_bloc.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/community/widgets/community_search_bar.dart';
import 'package:connected/presentation/screens/community/widgets/all_community.dart';
import 'package:connected/presentation/screens/community/widgets/other_community.dart';
import 'package:connected/presentation/widgets/side_heading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommunitySearchBloc(),
      child: DefaultTabController(
        length: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //side main heading

            const SideHeadingWidget(heading: 'Communities'),

            //search bar
            const CommunitySerachBar(),

            TabBar(
                onTap: (value) {
                  log('$value');
                },
                indicatorColor: Colors.red,
                dividerHeight: 1,
                tabAlignment: TabAlignment.fill,
                labelStyle: MyTextStyle.greyHeadingTextSmall,
                tabs: const [
                  Tab(
                    text: 'My Communities',
                    iconMargin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  ),
                  Tab(
                    text: 'Other Communities',
                  ),
                ]),
            const Expanded(
              child: TabBarView(children: [MyCommunity(), OtherCommunities()]),
            )
          ],
        ),
      ),
    );
  }
}
