import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/common/functions/date_functions/date_differnce.dart';
import 'package:connected/domain/fire_store_functions/discussion_db/discussion_db_functions.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/presentation/core/dialog_boxes/all_dialogue_box.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/editing_screens/screens/edit_discussion.dart';
import 'package:flutter/material.dart';

class DiscussionEditTab extends StatelessWidget {
  final String userId;
  final String discussionId;
  final Timestamp time;
  final int index;

  const DiscussionEditTab({super.key, required this.userId, required this.time, required this.index,required this.discussionId});


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(FirebaseConstants.userDb)
            .doc(userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return InkWell(
              // onTap: () {
              //   // Navigator.of(context).push(MaterialPageRoute(
              //   //     builder: (ctx) => OtherProfileScreen(
              //   //           userId: userId,
              //   //           index: index,
              //   //         )));
              // },
              child: ListTile(
                  leading: Hero(
                    tag: 'profile$index',
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          snapshot.data![FirebaseConstants.fieldImage]),
                    ),
                  ),
                  title: Text(
                    snapshot.data![FirebaseConstants.fieldRealname],
                    style: MyTextStyle.commonButtonText,
                    textScaler: TextScaler.noScaling,
                  ),
                  subtitle: Text(
                    dateDiffernce(today:DateTime.now(),date: time.toDate()),
                    style: MyTextStyle.smallText,
                    textScaler: TextScaler.noScaling,
                  ),
                  trailing: userId==UserDbFunctions().userId?PopupMenuButton(
                      surfaceTintColor: Colors.black,
                      itemBuilder: (context) => [
                             PopupMenuItem(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>EditDiscussion(discssionId: discussionId)));
                              },
                              value: 1,
                              child: const Row(
                                children: [
                                  Icon(Icons.edit),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Edit Discussion",style: MyTextStyle.commonButtonText)
                                ],
                              ),
                            ),
                             PopupMenuItem(
                              onTap: (){
                                showDialog(context: context, builder: (BuildContext ctx)=> WarningDialog(id1: discussionId,function: DiscussionDbFunctions(),));
                              },
                              value: 2,
                              child: const Row(
                                children: [
                                  Icon(Icons.delete_forever,color: Colors.red,),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Delete Discussion",style: MyTextStyle.commonButtonTextRed,)
                                ],
                              ),
                            )
                          ]):PopupMenuButton(
                      surfaceTintColor: Colors.black,
                      itemBuilder: (context) => [
                             const PopupMenuItem(
                              value: 1,
                              child: Row(
                                children: [
                                  Icon(Icons.edit),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Report",style: MyTextStyle.commonButtonText)
                                ],
                              ),
                            ),
                          ])));
          }
        });
  }
}