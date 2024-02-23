
import 'dart:io';

import 'package:connected/application/bloc/ai_generate_bloc/ai_generate_bloc.dart';
import 'package:connected/application/bloc/ai_generate_bloc/ai_generate_event.dart';
import 'package:connected/application/bloc/ai_generate_bloc/ai_generate_state.dart';
import 'package:connected/application/bloc/create_discussion_bloc/create_discussion_bloc.dart';
import 'package:connected/application/bloc/create_discussion_bloc/create_discussion_state.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:material_speed_dial/material_speed_dial.dart';
import '../../../../application/bloc/create_discussion_bloc/create_discussion_event.dart';

class CreateDiscussion extends StatelessWidget {
  const CreateDiscussion({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleCont = TextEditingController();
    TextEditingController bodyCont = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Stack(
      children: [
        //whole form
        BlocListener<AiGenerateBloc, AiGenerateState>(
          listener: (context, state) {
            if (state is AiGeneratedState) {
              bodyCont.text = state.generatedText;
            }
          },
          child: SafeArea(
            child: BlocProvider(
              create: (context) => CreateDiscussionBloc(),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //title section
                    Column(
                      children: [
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
                              if (!RegExp(r'^\S+(?!\d+$)')
                                  .hasMatch(value ?? '')) {
                                return 'Please enter a valid body.';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
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
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //SUBMIT BUTTON
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
                                  }),

                              //ATTECHMENTS AND AI ROW
                              Row(
                                children: [
                                  //attatchment icon
                                  IconButton(
                                      onPressed: () {
                                        BlocProvider.of<CreateDiscussionBloc>(
                                                context)
                                            .add(OnImagePickedEvent());
                                      },
                                      icon: const Icon(Icons.attach_file)),
                                  SpeedDial(
                                      expandedChild: Image.asset(
                                        'assets/icons/ai.png',
                                      ),
                                      backgroundColor: Colors.white,
                                      children: [
                                        SpeedDialChild(
                                            onPressed: () {
                                              if (bodyCont.text
                                                  .trim()
                                                  .isEmpty) {
                                                return;
                                              }
                                              BlocProvider.of<AiGenerateBloc>(
                                                      context)
                                                  .add(GenerateClickEvent(
                                                      initialText:
                                                          bodyCont.text));
                                            },
                                            backgroundColor: Colors.white,
                                            label: const Text(
                                              'Generate Text With AI',
                                              style: MyTextStyle
                                                  .commonButtonTextWhite,
                                            ),
                                            child: const Icon(Icons.abc)),
                                        SpeedDialChild(
                                            onPressed: () {
                                              if (bodyCont.text
                                                  .trim()
                                                  .isEmpty) {
                                                return;
                                              }
                                              BlocProvider.of<AiGenerateBloc>(
                                                      context)
                                                  .add(EnhanceClickEvent(
                                                      initialText:
                                                          bodyCont.text));
                                            },
                                            backgroundColor: Colors.white,
                                            label: const Text(
                                              'Enhance Your Description With AI',
                                              style: MyTextStyle
                                                  .commonButtonTextWhite,
                                            ),
                                            child: const Icon(
                                                Icons.upcoming_sharp))
                                      ],
                                      child: Image.asset(
                                        'assets/icons/ai.png',
                                      ))
                                ],
                              ),
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
        ),
        BlocBuilder<AiGenerateBloc, AiGenerateState>(
          builder: (context, state) {
            if (state is AiGereratingState) {
              return Positioned(child: loadingImage(context: context));
            } else {
              return const SizedBox();
            }
          },
        )
      ],
    );
  }

  //loading image Widget
  Widget loadingImage({required BuildContext context}) {
    return Container(
      color: const Color.fromARGB(101, 0, 0, 0),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Lottie.asset('assets/lottie/generating.json'),
      ),
    );
  }
}
