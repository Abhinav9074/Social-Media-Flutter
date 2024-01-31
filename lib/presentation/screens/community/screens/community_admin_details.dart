import 'package:connected/application/bloc/community_creation_bloc/community_creation_bloc.dart';
import 'package:connected/application/bloc/community_name_bloc/community_name_bloc.dart';
import 'package:connected/presentation/core/media_query/media_query.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/community/screens/community_edit_screen.dart';
import 'package:connected/presentation/screens/community/screens/community_request_screen.dart';
import 'package:connected/presentation/screens/community/widgets/community_user_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunityDetailsAdmin extends StatelessWidget {
  final String image;
  final String communityId;
  final String communityName;
  final bool isPrivate;
  final String communityDescription;

  const CommunityDetailsAdmin(
      {super.key,
      required this.image,
      required this.communityId,
      required this.communityName,
      required this.isPrivate,
      required this.communityDescription});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          isPrivate == true
              ? IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => CommunityJoiningRequests(
                            communityId: communityId)));
                  },
                  icon: const Icon(Icons.notifications))
              : const SizedBox(),

          //admin handle button
          PopupMenuButton(
              surfaceTintColor: Colors.black,
              itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: const Row(
                        children: [
                          Icon(
                            Icons.edit,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Edit Community",
                            style: MyTextStyle.commonButtonText,
                          )
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) {
                          return BlocProvider(
                            create: (context) => CommunityCreationBloc(),
                            child: BlocProvider(
                              create: (context) => CommunityNameBloc(),
                              child:
                                  EditCommunityPage(communityId: communityId),
                            ),
                          );
                        }));
                      },
                    )
                  ])
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //profile picture and name
            Hero(
              tag: 'communityProfile',
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(image),
                  radius: MediaQueryCustom.profilePicSize(context),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Hero(
                tag: 'communityName',
                child: Text(
                  communityName,
                  style: MyTextStyle.mediumHeadingText,
                )),

            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
                  child: Text(
                    'Description',
                    style: MyTextStyle.commonButtonText,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 20),
                  child: Text(
                    communityDescription,
                    style: MyTextStyle.descriptionText,
                  ),
                ),
              ],
            ),

            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 0, 20),
                  child: Text(
                    'Members',
                    style: MyTextStyle.commonButtonText,
                  ),
                ),
              ],
            ),

            //all members list
            Expanded(
                child: CommunityUserList(
              commuintyId: communityId,
            ))
          ],
        ),
      ),
    );
  }
}
