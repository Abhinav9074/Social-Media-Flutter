import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/application/bloc/create_discussion_bloc/create_discussion_bloc.dart';
import 'package:connected/application/bloc/create_discussion_bloc/create_discussion_state.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/bloc/create_discussion_bloc/create_discussion_event.dart';

class EditDiscussion extends StatelessWidget {
  final String discssionId;

  const EditDiscussion({super.key, required this.discssionId});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleCont = TextEditingController();
    TextEditingController bodyCont = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => CreateDiscussionBloc(),
      child: Scaffold(
          appBar: AppBar(),
          body: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(FirebaseConstants.discussionDb)
                  .doc(discssionId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  titleCont.text =
                      snapshot.data![FirebaseConstants.fieldDiscussionTitle];
                  bodyCont.text = snapshot
                      .data![FirebaseConstants.fieldDiscussionDescription];

                  return SingleChildScrollView(
                    child: SafeArea(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            //title section
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                              child: TextFormField(
                                maxLength: 50,
                                controller: titleCont,
                                style: MyTextStyle.greyHeadingText,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Title',
                                  hintStyle: MyTextStyle.greyHeadingText,
                                ),
                                validator: (value) {
                                  if (!RegExp(r'^\S+(?!\d+$)')
                                      .hasMatch(value ?? '')) {
                                    return 'Please enter a valid title';
                                  }
                                  return null;
                                },
                              ),
                            ),

                            //body section
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: TextFormField(
                                controller: bodyCont,
                                autocorrect: true,
                                style: MyTextStyle.greyButtonText,
                                maxLines: 7,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Body',
                                  hintStyle: MyTextStyle.greyButtonText,
                                ),
                                validator: (value) {
                                  if (!RegExp(r'^\S+(?!\d+$)')
                                      .hasMatch(value ?? '')) {
                                    return 'Please enter a valid body.';
                                  }
                                  return null;
                                },
                              ),
                            ),

                            //submssion row
                            BlocBuilder<CreateDiscussionBloc,
                                CreateDiscussionState>(
                              builder: (context, state) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(),
                                      ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.red),
                                          ),
                                          child: const Text(
                                            'Update Discussion',
                                            style: MyTextStyle
                                                .commonButtonTextWhite,
                                          ),
                                          onPressed: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              if (state is ImageSelectedState) {
                                                BlocProvider.of<
                                                            CreateDiscussionBloc>(
                                                        context)
                                                    .add(DiscussionEditEvent(
                                                        discussionId:
                                                            discssionId,
                                                        title: titleCont.text,
                                                        imageFile: '',
                                                        description:
                                                            bodyCont.text,
                                                        likes: 0,
                                                        disLikes: 0,
                                                        contributions: [],
                                                        edited: true,
                                                        tags: []));
                                                screenChangeNotifier.value = 0;
                                              } else {
                                                BlocProvider.of<
                                                            CreateDiscussionBloc>(
                                                        context)
                                                    .add(DiscussionEditEvent(
                                                        discussionId:
                                                            discssionId,
                                                        title: titleCont.text,
                                                        imageFile: '',
                                                        description:
                                                            bodyCont.text,
                                                        likes: 0,
                                                        disLikes: 0,
                                                        contributions: [],
                                                        edited: true,
                                                        tags: []));
                                                screenChangeNotifier.value = 0;
                                              }
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                            }
                                          })
                                    ],
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
              })),
    );
  }
}
