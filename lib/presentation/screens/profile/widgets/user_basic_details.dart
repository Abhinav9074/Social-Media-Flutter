import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/profile/widgets/follow_tab.dart';
import 'package:flutter/material.dart';

class UserBasicDeatils extends StatelessWidget {
  final String bio;
  final String name;
  final String location;
  final String following;
  final String followers;
  final String count;

  const UserBasicDeatils(
      {super.key,
      required this.bio,
      required this.name,
      required this.location,
      required this.following,
      required this.followers,
      required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //username
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                name,
                style: MyTextStyle.discussionHeadingText,
              ),
            ),
          ],
        ),

        //Bio

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              bio,
              style: MyTextStyle.smallText,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_on,
              size: 15,
              color: Colors.red,
            ),
            Text(
              location,
              style: MyTextStyle.smallText,
            ),
          ],
        ),

        //following , followers and discussions

        Padding(
          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FollowTab(action: 'Following', count: following),
              const SizedBox(
                width: 40,
              ),
              FollowTab(action: 'Followers', count: followers),
              const SizedBox(
                width: 40,
              ),
              FollowTab(action: 'Discussions', count: count),
            ],
          ),
        ),
      ],
    );
  }
}
