// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/application/bloc/community_posting_bloc/community_posting_bloc.dart';
import 'package:connected/application/bloc/community_posting_bloc/community_posting_event.dart';
import 'package:connected/application/bloc/community_posting_bloc/community_posting_state.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/community_db/community_post_functions.dart';
import 'package:connected/domain/models/community_model/community_post_model.dart';
import 'package:connected/presentation/core/media_query/media_query.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunityPostImageScreen extends StatelessWidget {
  final String communityId;

  const CommunityPostImageScreen({super.key, required this.communityId});

  @override
  Widget build(BuildContext context) {
    TextEditingController textCont = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back,color: Colors.white,)),
      ),
      body: BlocBuilder<CommunityPostingBloc, CommunityPostingState>(
        builder: (context, state) {
          if(state is CommunityPostingImagePickedState){
            return SingleChildScrollView(
              child: Column(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQueryCustom.imageTextCreateContainerHeight(context)
                    ),
                    child: Image.file(File(state.image))),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: TextFormField(
                      controller: textCont,
                      style: MyTextStyle.commonButtonTextWhite,
                      decoration:  InputDecoration(
                        suffixIcon: IconButton(onPressed: ()async{
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
                          time: '');
                      await CommunityPostDbFunctions().createPost(dates);
                    }
                    
                          BlocProvider.of<CommunityPostingBloc>(context).add(CommunityPostedEvent(description: textCont.text,communityId: communityId,image: state.image));
                          Navigator.of(context).pop();
                        }, icon: const Icon(Icons.send,color: Colors.white,)),
                        hintText: 'Add Text',
                        hintStyle: MyTextStyle.commonButtonTextWhite,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }else{
            return const SizedBox();
          }
        }
      ),
    );
  }
}
