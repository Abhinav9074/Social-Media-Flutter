import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/application/bloc/other_profile_bloc/other_profile_bloc.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/common/functions/date_functions/date_differnce.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';

class UserDeatilsTile extends StatelessWidget {
  final String userId;
  final Timestamp time;
  final int index;
  final bool edited;

  const UserDeatilsTile(
      {super.key,
      required this.userId,
      required this.time,
      required this.index,
      required this.edited});

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
                          snapshot.data![FirebaseConstants.fieldImage]),
                    ),
                  ),
                  title: Text(
                    '${snapshot.data![FirebaseConstants.fieldRealname]}'.titleCase,
                    style: MyTextStyle.commonButtonText,
                    textScaler: TextScaler.noScaling,
                  ),
                  subtitle: edited == false
                      ? Text(
                          dateDiffernce(DateTime.now(), time.toDate()),
                          style: MyTextStyle.smallText,
                          textScaler: TextScaler.noScaling,
                        )
                      : Text(
                          'Edited : ${dateDiffernce(DateTime.now(), time.toDate())}',
                          style: MyTextStyle.smallText,
                          textScaler: TextScaler.noScaling,
                        ),
                  trailing: PopupMenuButton(
                      surfaceTintColor: Colors.black,
                      itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 1,
                              child: Row(
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
