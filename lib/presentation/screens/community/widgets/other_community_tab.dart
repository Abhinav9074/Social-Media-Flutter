import 'package:connected/application/bloc/community_join_bloc/community_join_bloc.dart';
import 'package:connected/application/bloc/community_join_bloc/community_join_event.dart';
import 'package:connected/application/bloc/community_join_bloc/community_join_state.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtherCommunityTab extends StatelessWidget {
  final String image;
  final String communityName;
  final String communityId;
  final int members;
  final bool communityType;
  final List<dynamic> requests;

  const OtherCommunityTab(
      {super.key,
      required this.image,
      required this.communityName,
      required this.members,
      required this.communityId,
      required this.requests,
      required this.communityType
      });


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityJoinBloc, CommunityJoinState>(
      builder: (context, state) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(image),
            radius: 30,
          ),
          title: Text(
            communityName,
            style: MyTextStyle.mediumHeadingText,
          ),
          subtitle: Text(
            '$members Members',
            style: MyTextStyle.greyHeadingTextSmall,
          ),
          trailing: state is CommunityJoinLoadingState
              ? Transform.scale(
                scale: 0.3,
                child: const CircularProgressIndicator())
              : state is CommunityJoinedState
                  ? TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.check),
                      label: const Text('Joined'))
                  : requests.contains(UserDbFunctions().userId)
                      ? TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.pending),
                          label: const Text('Pending',
                              style: MyTextStyle.greyHeadingTextSmall))
                      : TextButton.icon(
                          onPressed: () async {
                            BlocProvider.of<CommunityJoinBloc>(context).add(CommunityJoiningEvent(communityId: communityId, communityType: communityType));
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                          label: const Text(
                            'Join',
                            style: MyTextStyle.commonButtonText,
                          )),
        );
      },
    );
  }
}
