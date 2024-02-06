import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/presentation/core/media_query/media_query.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/profile/screens/self_discussion_view.dart';
import 'package:flutter/material.dart';

class SavedDiscussionTab extends StatelessWidget {
  final String id;
  const SavedDiscussionTab({super.key,required this.id});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.
            collection(FirebaseConstants.userDb).doc(UserDbFunctions().userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return ListView.builder(
                itemCount: snapshot.data![FirebaseConstants.fieldSavedDiscussions].length,
                itemBuilder: (context, index) {
                  final data = snapshot.data![FirebaseConstants.fieldSavedDiscussions][index];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => SelfDiscussionView(
                                discussionId: data,
                              )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 7, 15, 7),
                      child: Container(
                        height: MediaQueryCustom.discussionTabHeight(context),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: SizedBox(
                                      width: 250,
                                      child: StreamBuilder(
                                        stream: FirebaseFirestore.instance.collection(FirebaseConstants.discussionDb).doc(data).snapshots(),
                                        builder: (context, snapshot) {
                                          if(!snapshot.hasData){
                                            return const SizedBox();
                                          }else{
                                            return Text(
                                            snapshot.data![FirebaseConstants
                                                .fieldDiscussionTitle],
                                            style: MyTextStyle.commonButtonText,
                                            textScaler: TextScaler.noScaling,
                                          );
                                          }
                                        }
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
        });
  }
}
