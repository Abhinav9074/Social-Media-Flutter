import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/profile/widgets/discussion_tab.dart';
import 'package:connected/presentation/screens/profile/widgets/profile_pic_widget.dart';
import 'package:connected/presentation/screens/profile/widgets/user_basic_details.dart';
import 'package:connected/presentation/screens/profile_edit/screens/profile_edit_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
              surfaceTintColor: Colors.black,
              itemBuilder: (context) => [
                     PopupMenuItem(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>const EditProfileScreen()));
                      },
                      value: 1,
                      child: const Row(
                        children: [
                          Icon(Icons.edit),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Edit Profile")
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 2,
                      child: Row(
                        children: [
                          Icon(Icons.trending_up),
                          SizedBox(
                            width: 10,
                          ),
                          Text("My Activity")
                        ],
                      ),
                    )
                  ])
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(FirebaseConstants.userDb)
              .doc(UserDbFunctions().userId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //style wrapper
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 30,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        //heading
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 8, 0, 20),
                              child: Text(
                                'My Profile',
                                style: MyTextStyle.strongtHeadingText,
                              ),
                            ),
                          ],
                        ),

                        //profile pic
                        ProfilePicture(
                            image:
                                snapshot.data![FirebaseConstants.fieldImage]),

                        //user basic details

                        UserBasicDeatils(
                            bio: 'A person with no desire',
                            name:
                                snapshot.data![FirebaseConstants.fieldRealname],
                            location: 'Calicut , India',
                            following:
                                '${snapshot.data![FirebaseConstants.fieldFollowing] == null ? 0 : snapshot.data![FirebaseConstants.fieldFollowing].length}',
                            followers:
                                '${snapshot.data![FirebaseConstants.fieldFollowers] == null ? 0 : snapshot.data![FirebaseConstants.fieldFollowers].length}',
                            count:
                                '${snapshot.data![FirebaseConstants.fieldDiscussions] == null ? 0 : snapshot.data![FirebaseConstants.fieldDiscussions].length}'),

                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                    child: Text('All Discussions',style: MyTextStyle.discussionHeadingText,),
                  ),

                  //all discussions

                   Expanded(child: DiscussionTab(count: snapshot.data![FirebaseConstants.fieldDiscussions] == null ? 0 : snapshot.data![FirebaseConstants.fieldDiscussions].length,id: UserDbFunctions().userId,))
                ],
              ),
            );
          }),
    );
  }
}
