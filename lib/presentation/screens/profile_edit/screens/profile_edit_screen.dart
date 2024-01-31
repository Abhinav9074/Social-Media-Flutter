import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/application/bloc/profile_edit_bloc/profile_edit_bloc.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/profile_edit/widgets/old_profile.dart';
import 'package:connected/presentation/screens/profile_edit/widgets/username_edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameCont = TextEditingController();
    return BlocProvider(
      create: (context) => ProfileEditBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edit Profile',
            style: MyTextStyle.commonHeadingText,
          ),
          centerTitle: true,
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
              } else {
                return SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //profile picture editing
                      OldProfilePicture(
                          image: snapshot.data![FirebaseConstants.fieldImage]),

                      //username editing
                      EditUsername(userCont: usernameCont)
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}