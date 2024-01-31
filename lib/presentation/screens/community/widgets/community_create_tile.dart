// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:connected/application/bloc/community_creation_bloc/community_creation_bloc.dart';
import 'package:connected/application/bloc/community_creation_bloc/community_creation_event.dart';
import 'package:connected/application/bloc/community_creation_bloc/community_creation_state.dart';
import 'package:connected/application/bloc/community_name_bloc/community_name_bloc.dart';
import 'package:connected/application/bloc/community_name_bloc/community_name_event.dart';
import 'package:connected/application/bloc/community_name_bloc/community_name_state.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunityCreateTile extends StatelessWidget {
  final TextEditingController controller;

  const CommunityCreateTile({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: InkWell(
        onTap: () {
          BlocProvider.of<CommunityCreationBloc>(context)
              .add(CommunityImageTappedEvent());
        },
        child: BlocBuilder<CommunityCreationBloc, CommunityCreationState>(
          builder: (context, state) {
            if (state is CommunityImagePickedState) {
              return CircleAvatar(
                radius: 40,
                backgroundImage: FileImage(File(state.image)),
              );
            } else if(state is CommunitySwitchState){
              if(state.image.isNotEmpty){
                return CircleAvatar(
                radius: 40,
                backgroundImage: FileImage(File(state.image)),
              );
              }else{
                return  const CircleAvatar(
                radius: 40,
                child: Icon(Icons.camera_alt),
              );
              }
            }else{
              return const CircleAvatar(
                radius: 40,
                child: Icon(Icons.camera_alt),
              );
            }
          },
        ),
      ),
      title: BlocBuilder<CommunityNameBloc, CommunityNameState>(
          builder: (context, state) {
        return TextFormField(
          controller: controller,
          onChanged: (value) {
            BlocProvider.of<CommunityNameBloc>(context)
                .add(CommunityNameChangeEvent(communityName: value));
          },
          maxLength: 100,
          decoration: InputDecoration(
              suffixIcon: state is NewCommunityNameState
                  ? const Icon(
                      Icons.check,
                      color: Colors.green,
                    )
                  : state is CommunityNameExistState
                      ? const Icon(
                          Icons.close,
                          color: Color.fromARGB(255, 255, 0, 0),
                        )
                      : state is CommunityNameCheckingState
                          ? Transform.scale(
                              scale: 0.3,
                              child: const CircularProgressIndicator())
                          : state is NewCommunityNameState
                              ? const SizedBox()
                              : const SizedBox(),
              hintText: 'Community Name',
              hintStyle: MyTextStyle.optionTextMediumLight),
        );
      }),
    );
  }
}
