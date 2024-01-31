// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/application/bloc/community_posting_bloc/community_posting_bloc.dart';
import 'package:connected/application/bloc/community_posting_bloc/community_posting_event.dart';
import 'package:connected/application/bloc/community_posting_bloc/community_posting_state.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/community_db/community_db_functions.dart';
import 'package:connected/domain/fire_store_functions/community_db/community_post_functions.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/domain/models/community_model/community_post_model.dart';
import 'package:connected/presentation/screens/community/screens/community_post_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CommunityMessageTab extends StatelessWidget {
  final String communityId;

  const CommunityMessageTab({super.key, required this.communityId});

  @override
  Widget build(BuildContext context) {
    TextEditingController textCont = TextEditingController();
    return BlocListener<CommunityPostingBloc, CommunityPostingState>(
      listener: (context, state) {
        if (state is CommunityPostingImagePickedState) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  CommunityPostImageScreen(communityId: communityId)));
        }
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
        child: TextFormField(
          controller: textCont,
          onChanged: (value) async {
            CommunityDbFunctions()
                .userTyping(UserDbFunctions().userId, communityId);
          },
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: IconButton(
                  onPressed: () {
                    BlocProvider.of<CommunityPostingBloc>(context)
                        .add(CommunityPostingImagePickEvent());
                  },
                  icon: const Icon(Icons.attachment)),
              suffixIcon: IconButton(
                  onPressed: () async {
                    //checking whether the date exist or not
                    final dateData = await FirebaseFirestore.instance
                        .collection(FirebaseConstants.communityPostDb)
                        .where(FirebaseConstants.fieldCommunityId,
                            isEqualTo: communityId)
                        .where(FirebaseConstants.fieldCommunityPostAlertMsg,
                            isEqualTo:
                                DateTime.now().toString().substring(0, 10))
                        .get();
                    if (dateData.docs.isEmpty) {
                      //adding the date to the community chat list
                      final dates = CommunityPostModel(
                          alert: true,
                          communityId: communityId,
                          userId: '',
                          alertMsg: DateTime.now().toString().substring(0, 10),
                          image: '',
                          time: DateFormat.jm().toString());
                      await CommunityPostDbFunctions().createPost(dates);
                    }

                    //creating text message
                    BlocProvider.of<CommunityPostingBloc>(context).add(
                        CommunityPostedEvent(
                            description: textCont.text,
                            communityId: communityId,
                            image: ''));

                    textCont.clear();
                  },
                  icon: const Icon(Icons.send)),
              contentPadding: const EdgeInsets.all(0),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none)),
        ),
      ),
    );
  }
}
