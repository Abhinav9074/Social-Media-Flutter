import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/community_db/community_db_functions.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

class CommunityUserList extends StatelessWidget {
  final String commuintyId;

  const CommunityUserList({super.key, required this.commuintyId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(FirebaseConstants.communityDb)
            .doc(commuintyId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return ListView.builder(
                itemCount: snapshot
                    .data![FirebaseConstants.fieldCommunityMembers].length,
                itemBuilder: (context, index) {
                  final admin =
                      snapshot.data![FirebaseConstants.fieldCommunityAdminId];
                  final data = snapshot
                      .data![FirebaseConstants.fieldCommunityMembers][index];
                  return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(FirebaseConstants.userDb)
                          .doc(data)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox();
                        } else {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  snapshot.data![FirebaseConstants.fieldImage]),
                            ),
                            title: Text(
                              '${snapshot.data![FirebaseConstants.fieldRealname]}'.titleCase,
                              style: MyTextStyle.descriptionText,
                            ),
                            trailing: data == admin
                                ? const Text(
                                    'Admin',
                                    style: MyTextStyle.successText,
                                  )
                                : admin==UserDbFunctions().userId?PopupMenuButton(
                                    surfaceTintColor: Colors.black,
                                    itemBuilder: (context) => [
                                          PopupMenuItem(
                                            value: 1,
                                            child: const Row(
                                              children: [
                                                Icon(
                                                  Icons.report,
                                                  color: Colors.red,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Remove",
                                                  style: MyTextStyle.errorText,
                                                )
                                              ],
                                            ),
                                            onTap: () {
                                              AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.warning,
                                                animType: AnimType.rightSlide,
                                                title: 'Are You Sure',
                                                desc:
                                                    'Do you want to remove ${snapshot.data![FirebaseConstants.fieldRealname]} from the community ?',
                                                btnCancelOnPress: () {},
                                                btnOkOnPress: () async{
                                                  await CommunityDbFunctions().removeFromCommunity(commuintyId, data);
                                                },
                                              ).show();
                                            },
                                          )
                                        ]):const SizedBox(),
                          );
                        }
                      });
                });
          }
        });
  }
}
