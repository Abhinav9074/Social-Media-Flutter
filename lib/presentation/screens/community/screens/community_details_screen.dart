import 'package:connected/presentation/core/media_query/media_query.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/community/widgets/community_user_list.dart';
import 'package:flutter/material.dart';

class CommunityDetails extends StatelessWidget {
  final String image;
  final String communityId;
  final String communityName;
  final String communityDescription;

  const CommunityDetails(
      {super.key,
      required this.image,
      required this.communityId,
      required this.communityName,
      required this.communityDescription});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                      child: Text('Description',style: MyTextStyle.commonButtonText,),
                    ),
                    
                  ],
                ),
                Row(
                  children: [
                    Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 20),
                          child: Text(communityDescription,style: MyTextStyle.descriptionText,),
                        ),
                  ],
                ),

                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 20, 0, 20),
                      child: Text('Members',style: MyTextStyle.commonButtonText,),
                    ),
                  ],
                ),

                //all members list
                Expanded(child: CommunityUserList(commuintyId: communityId,))        
          ],
        ),
      ),
    );
  }
}
