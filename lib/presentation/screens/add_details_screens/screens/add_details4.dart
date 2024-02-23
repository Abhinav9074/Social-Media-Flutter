// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:connected/application/bloc/add_details_bloc/add_details_bloc.dart';
import 'package:connected/application/bloc/add_details_bloc/add_details_event.dart';
import 'package:connected/application/bloc/add_details_bloc/add_details_state.dart';
import 'package:connected/application/bloc/image_picker_bloc/image_picker_bloc.dart';
import 'package:connected/application/bloc/image_picker_bloc/image_picker_event.dart';
import 'package:connected/application/bloc/image_picker_bloc/image_picker_state.dart';
import 'package:connected/domain/shared_prefrences/login_logout/login_logout.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/add_details_screens/widgets/logo_heading.dart';
import 'package:connected/presentation/screens/main_page/screens/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddProfilePicture extends StatelessWidget {
  final String password;
  const AddProfilePicture({super.key,required this.password});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddDetailsBloc, AddDetailsState>(
      listener: (context, state) {
        if(state is ReadyToGoState){
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (ctx) =>  const MainPage()),
                        (route) => false);
                  }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Logo & Heading
                const Column(
                  children: [
                    LogoAndHeading(heading: 'Set Up Your Profile'),
                    Text(
                      'Select Your Profile Picture',
                      style: MyTextStyle.optionTextMediumLight,
                    )
                  ],
                ),

                //image picker
                BlocBuilder<ImagePickerBloc, ImagePickerState>(
                  builder: (context, state) {
                    if (state is ImagePickedState) {
                      return InkWell(
                          onTap: () {
                            BlocProvider.of<ImagePickerBloc>(context)
                                .add(ImagePickedEvent());
                          },
                          child: CircleAvatar(
                            radius: 90,
                            backgroundColor:
                                const Color.fromARGB(255, 211, 211, 211),
                            backgroundImage: FileImage(File(state.image.path)),
                          ));
                    } else if (state is ImageUploadingState) {
                      return InkWell(
                          onTap: () {
                            BlocProvider.of<ImagePickerBloc>(context)
                                .add(ImagePickedEvent());
                          },
                          child: CircleAvatar(
                            radius: 90,
                            backgroundColor:
                                const Color.fromARGB(255, 211, 211, 211),
                            backgroundImage: FileImage(File(state.image.path)),
                          ));
                    } else {
                      return InkWell(
                          onTap: () {
                            BlocProvider.of<ImagePickerBloc>(context)
                                .add(ImagePickedEvent());
                          },
                          child: const CircleAvatar(
                            radius: 90,
                            backgroundColor: Color.fromARGB(255, 211, 211, 211),
                            child: FaIcon(
                              FontAwesomeIcons.plus,
                              color: Color.fromARGB(255, 116, 116, 116),
                              size: 100,
                            ),
                          ));
                    }
                  },
                ),

                //button
                BlocConsumer<ImagePickerBloc, ImagePickerState>(
                  listener: (context, state) async {
                    if (state is ImageUploadedState) {
                      BlocProvider.of<AddDetailsBloc>(context)
                          .add(AddImageEvent(image: state.image,password: password));

                      await SharedPrefLogin.setLogin();
                    }
                  },
                  builder: (context, state) {
                    if (state is ImagePickedState) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<ImagePickerBloc>(context)
                                .add(ImageUploadEvent());
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black)),
                          child: const Text(
                            'Continue',
                            style: MyTextStyle.commonButtonTextWhite,
                          ),
                        ),
                      );
                    } else if (state is ImageUploadingState) {
                      return const Padding(
                        padding: EdgeInsets.only(bottom: 30),
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 145, 143, 143))),
                          child: const Text(
                            'Continue',
                            style: MyTextStyle.commonButtonTextWhite,
                          ),
                        ),
                      );
                    }
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
