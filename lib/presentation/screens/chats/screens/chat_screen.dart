import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/chats/screens/chat_inside_screen.dart';
import 'package:connected/presentation/widgets/side_heading_widget.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //chat heading
        const SideHeadingWidget(heading: 'Chats'),
        const SizedBox(height: 20,),

        //chat list of users
        chatUserList()
      ],
    );
  }

  //all user list
  Widget chatUserList() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(FirebaseConstants.userDb)
            .where(FirebaseConstants.fieldFollowers,
                arrayContains: UserDbFunctions().userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Expanded(
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data!.docs[index];
                    return userList(receiverId: data.id, image: data[FirebaseConstants.fieldImage], text: data[FirebaseConstants.fieldRealname], ctx: context);
                  }),
            );
          }
        });
  }

  //individual user tile
  Widget userList({required String receiverId,required String image,required String text,required BuildContext ctx}
  ) {
    return InkWell(
      onTap: (){
        Navigator.of(ctx).push(MaterialPageRoute(builder: (ctx)=>ChatInsideScreen(receiverId: receiverId)));
      },
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(image),
        ),
        title: Text(text.titleCase,style: MyTextStyle.optionTextMediumLight,),
      ),
    );
  }
}
