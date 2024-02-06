import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/domain/streams/chat_user_stream.dart';
import 'package:connected/presentation/core/media_query/media_query.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/chats/screens/chat_inside_screen.dart';
import 'package:connected/presentation/screens/chats/widgets/follwoing_follower_screen.dart';
import 'package:connected/presentation/widgets/side_heading_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:recase/recase.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //chat heading
          const SideHeadingWidget(heading: 'Chats'),
          const SizedBox(
            height: 20,
          ),

          //chat list of users
          chatUserList()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showBottomSheet(
              context: context,
              builder: (context) {
                return const FollowingAndFollowers();
              });
        },
        backgroundColor: Colors.red,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  //all user list
  Widget chatUserList() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(FirebaseConstants.userDb)
            .doc(UserDbFunctions().userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data![FirebaseConstants.fieldChats].isEmpty) {
            return Column(
              children: [
                SizedBox(
                  height: MediaQueryCustom.chatGifHeight(context),
                ),
                Lottie.asset('assets/lottie/chat.json'),
                const Text(
                  'Start Connecting with others ...',
                  style: MyTextStyle.greyButtonText,
                )
              ],
            );
          } else {
            return Expanded(
              child: ListView.builder(
                  itemCount:
                      snapshot.data![FirebaseConstants.fieldChats].length,
                  itemBuilder: (context, index) {
                    final data =
                        snapshot.data![FirebaseConstants.fieldChats][index];
                    return StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection(FirebaseConstants.userDb)
                            .doc(data)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const SizedBox();
                          } else {
                            return userList(
                                receiverId: data,
                                image: snapshot
                                    .data![FirebaseConstants.fieldImage],
                                text: snapshot
                                    .data![FirebaseConstants.fieldRealname],
                                ctx: context);
                          }
                        });
                  }),
            );
          }
        });
  }

  //individual user tile
  Widget userList(
      {required String receiverId,
      required String image,
      required String text,
      required BuildContext ctx}) {
    return InkWell(
      onTap: () {
        Navigator.of(ctx).push(MaterialPageRoute(
            builder: (ctx) => ChatInsideScreen(receiverId: receiverId)));
      },
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(image),
        ),
        title: Text(
          text.titleCase,
          style: MyTextStyle.optionTextMediumLight,
        ),
      ),
    );
  }

}
