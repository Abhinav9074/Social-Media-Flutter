import 'dart:io';

import 'package:connected/application/bloc/create_discussion_bloc/create_discussion_bloc.dart';
import 'package:connected/application/bloc/create_discussion_bloc/create_discussion_state.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/bloc/create_discussion_bloc/create_discussion_event.dart';

class CreateDiscussion extends StatelessWidget {
  const CreateDiscussion({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleCont = TextEditingController();
    TextEditingController bodyCont = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return SingleChildScrollView(
      child: SafeArea(
        child: BlocProvider(
          create: (context) => CreateDiscussionBloc(),
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
                      if (!RegExp(r'^\S+(?!\d+$)').hasMatch(value ?? '')) {
                        return 'Please enter a valid title.';
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
                      if (!RegExp(r'^\S+(?!\d+$)').hasMatch(value ?? '')) {
                        return 'Please enter a valid body.';
                      }
                      return null;
                    },
                  ),
                ),

                //image section
                BlocBuilder<CreateDiscussionBloc, CreateDiscussionState>(
                  builder: (context, state) {
                    if (state is ImageSelectedState) {
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: FileImage(File(state.image)),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),

                //submssion row
                BlocBuilder<CreateDiscussionBloc, CreateDiscussionState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                BlocProvider.of<CreateDiscussionBloc>(context)
                                    .add(OnImagePickedEvent());
                              },
                              icon: const Icon(Icons.attach_file)),
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red),
                              ),
                              child: const Text(
                                'Create Discussion',
                                style: MyTextStyle.commonButtonTextWhite,
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  if (state is ImageSelectedState) {
                                    BlocProvider.of<CreateDiscussionBloc>(
                                            context)
                                        .add(DiscussionCreateEvent(
                                            title: titleCont.text,
                                            imageFile: state.image,
                                            description: bodyCont.text,
                                            likes: 0,
                                            disLikes: 0,
                                            contributions: [],
                                            edited: false,
                                            tags: []));
                                    screenChangeNotifier.value = 0;
                                  } else {
                                    BlocProvider.of<CreateDiscussionBloc>(
                                            context)
                                        .add(DiscussionCreateEvent(
                                            title: titleCont.text,
                                            imageFile: '',
                                            description: bodyCont.text,
                                            likes: 0,
                                            disLikes: 0,
                                            contributions: [],
                                            edited: false,
                                            tags: []));
                                    screenChangeNotifier.value = 0;
                                  }
                                  
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
      ),
    );
  }
}
