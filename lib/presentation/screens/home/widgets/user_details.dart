import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/application/bloc/other_profile_bloc/other_profile_bloc.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/common/functions/date_functions/date_differnce.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/report/screens/discussion_report_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';

class UserDeatilsTile extends StatelessWidget {
  final String userId;
  final String discussionId;
  final Timestamp time;
  final int index;
  final bool edited;

  const UserDeatilsTile(
      {super.key,
      required this.userId,
      required this.time,
      required this.index,
      required this.edited,
      required this.discussionId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtherProfileBloc(),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(FirebaseConstants.userDb)
              .doc(userId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return ListTile(
                  leading: Hero(
                    tag: 'profile$index',
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          snapshot.data![FirebaseConstants.fieldImage],
                          ), 
                    ),
                  ),
                  title: snapshot.data![FirebaseConstants.fieldPremiumUser]==true?Row(
                    children: [
                      Text(
                        '${snapshot.data![FirebaseConstants.fieldRealname]}'.titleCase,
                        style: MyTextStyle.commonButtonText,
                        textScaler: TextScaler.noScaling,
                      ),
                      const SizedBox(width: 10,),
                      const Icon(Icons.verified,color: Colors.blue,size: 20,)
                    ],
                  ):Text(
                    '${snapshot.data![FirebaseConstants.fieldRealname]}'.titleCase,
                    style: MyTextStyle.commonButtonText,
                    textScaler: TextScaler.noScaling,
                  ),
                  subtitle: edited == false
                      ? Text(
                          dateDiffernce(today:DateTime.now(),date: time.toDate()),
                          style: MyTextStyle.smallText,
                          textScaler: TextScaler.noScaling,
                        )
                      : Text(
                          'Edited : ${dateDiffernce(today:DateTime.now(),date: time.toDate())}',
                          style: MyTextStyle.smallText,
                          textScaler: TextScaler.noScaling,
                        ),
                  trailing: PopupMenuButton(
                      surfaceTintColor: Colors.black,
                      itemBuilder: (context) => [
                             PopupMenuItem(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>DiscussionReportScreen(discussionId: discussionId)));
                              },
                              value: 1,
                              child: const Row(
                                children: [
                                  Icon(Icons.report),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Report")
                                ],
                              ),
                            )
                          ]));
            }
          }),
    );
  }
}
