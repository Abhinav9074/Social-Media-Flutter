import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/presentation/core/media_query/media_query.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/community/screens/community_admin_details.dart';
import 'package:connected/presentation/screens/community/screens/community_details_screen.dart';
import 'package:connected/presentation/screens/report/screens/community_report_screen.dart';
import 'package:flutter/material.dart';

class CommunityAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String image;
  final String communityId;

  const CommunityAppBar({
    super.key,
    required this.image,
    required this.communityId,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(FirebaseConstants.communityDb)
              .doc(communityId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return InkWell(
                onTap: () {
                  if (snapshot.data![FirebaseConstants.fieldCommunityAdminId] ==
                      UserDbFunctions().userId) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => CommunityDetailsAdmin(
                              image: image,
                              communityId: communityId,
                              communityName: snapshot
                                  .data![FirebaseConstants.fieldCommunityName],
                              isPrivate: snapshot.data![
                                  FirebaseConstants.fieldCommunityPrivate],
                              communityDescription: snapshot.data![
                                  FirebaseConstants.fieldCommunityDescription],
                            )));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => CommunityDetails(
                              image: image,
                              communityId: communityId,
                              communityName: snapshot
                                  .data![FirebaseConstants.fieldCommunityName],
                              communityDescription: snapshot.data![
                                  FirebaseConstants.fieldCommunityDescription],
                            )));
                  }
                },
                child: Container(
                  height: MediaQueryCustom.appBarHeight(context),
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(Icons.arrow_back)),
                              Hero(
                                  tag: 'communityProfile',
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(image),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Hero(
                                tag: 'communityName',
                                child: Text(
                                  snapshot.data![
                                      FirebaseConstants.fieldCommunityName],
                                  style: MyTextStyle.mediumHeadingText,
                                ),
                              ),
                            ],
                          ),
                          snapshot.data![FirebaseConstants.fieldCommunityAdminId]!=UserDbFunctions().userId?PopupMenuButton(itemBuilder: (context) {
                            return [
                               PopupMenuItem(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>CommunityReportPage(communityId: communityId)));
                                },
                                  child: const Row(
                                children: [
                                  Icon(
                                    Icons.report,
                                    color: Colors.red,
                                  ),
                                  Text('Report', style: MyTextStyle.errorText)
                                ],
                              ))
                            ];
                          }):const SizedBox()
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 100);
}
