import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/chat_service/chat_services.dart';
import 'package:connected/domain/streams/chat_user_stream.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/chats/screens/chat_inside_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FollowingAndFollowers extends StatelessWidget {
  final String? discussionId;
  final String? discussionName;

  const FollowingAndFollowers(
      {super.key, this.discussionId, this.discussionName});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: chatUserDisplayStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else if (snapshot.data!.isEmpty) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 0, 5),
                      child: Text(
                        'My Connections',
                        style: MyTextStyle.commonButtonText,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 10, 5),
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.close)),
                    )
                  ],
                ),
                Center(child: Lottie.asset('assets/lottie/no_follow.json')),
                const Text(
                  'Follow More to Connect...',
                  style: MyTextStyle.greyButtonText,
                ),
              ],
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 0, 5),
                      child: Text(
                        'My Connections',
                        style: MyTextStyle.commonButtonText,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 10, 5),
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.close)),
                    )
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: ((context, index) {
                        final data = snapshot.data![index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(
                                  data[FirebaseConstants.fieldImage]),
                            ),
                            title: Text(
                              data[FirebaseConstants.fieldRealname],
                              style: MyTextStyle.googleButton,
                            ),
                            trailing: ElevatedButton(
                                onPressed: () async {
                                  if (discussionId != null) {
                                    Navigator.of(context).pop();
                                    await ChatServices().shareDiscussion(
                                        data['id'],
                                        discussionId!,
                                        discussionName!);
                                  } else {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) => ChatInsideScreen(
                                                receiverId: data['id'])));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    backgroundColor: Colors.blue),
                                child: Text(
                                  discussionId == null ? 'Message' : 'Send',
                                  style: MyTextStyle.commonButtonTextWhite,
                                )),
                          ),
                        );
                      })),
                ),
              ],
            );
          }
        });
  }
}
