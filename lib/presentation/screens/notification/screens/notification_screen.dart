// ignore_for_file: unnecessary_string_interpolations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/common/functions/date_functions/date_differnce.dart';
import 'package:connected/domain/streams/notification_stream.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
          stream: notificationStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final data = snapshot.data![index];
                            return data[FirebaseConstants
                                        .fieldNotificationCreatedUser] !=
                                    null
                                ? StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection(FirebaseConstants.userDb)
                                        .doc(data[FirebaseConstants
                                            .fieldNotificationCreatedUser])
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return const SizedBox();
                                      } else {
                                        return ListTile(
                                          leading: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                snapshot.data![FirebaseConstants
                                                    .fieldImage]),
                                          ),
                                          title: Text(
                                            '${snapshot.data![FirebaseConstants.fieldRealname]} ${data[FirebaseConstants.fieldNotificationMessage]}',
                                            style: MyTextStyle.descriptionText,
                                          ),
                                          subtitle: Text(
                                            '${dateDiffernce(today: DateTime.now(), date: data[FirebaseConstants.fieldNotificationTime].toDate())}',
                                            style: MyTextStyle
                                                .greyHeadingTextSmall,
                                          ),
                                        );
                                      }
                                    })
                                : ListTile(
                                    leading: const CircleAvatar(
                                      backgroundImage: AssetImage(
                                          'assets/icons/verified.png'),
                                    ),
                                    title: Text(
                                      '${data[FirebaseConstants.fieldNotificationMessage]}',
                                      style: MyTextStyle.descriptionText,
                                    ),
                                    subtitle: Text(
                                      '${dateDiffernce(today: DateTime.now(), date: data[FirebaseConstants.fieldNotificationTime].toDate())}',
                                      style: MyTextStyle.greyHeadingTextSmall,
                                    ),
                                  );
                          }))
                ],
              );
            }
          }),
    );
  }
}
