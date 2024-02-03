import 'dart:io';

import 'package:connected/application/bloc/profile_edit_bloc/profile_edit_bloc.dart';
import 'package:connected/application/bloc/profile_edit_bloc/profile_edit_event.dart';
import 'package:connected/presentation/core/media_query/media_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OldProfilePicture extends StatelessWidget {
  final String image;
  final bool network;

  const OldProfilePicture({super.key, required this.image,required this.network});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
          onTap: (){
            BlocProvider.of<ProfileEditBloc>(context).add(ProfilePicTapEvent());
          },
          child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: network==true?CircleAvatar(
                      backgroundImage: NetworkImage(image),
                      radius: MediaQueryCustom.profilePicSize(context),
                    ):CircleAvatar(
                      backgroundImage: FileImage(File(image)),
                      radius: MediaQueryCustom.profilePicSize(context),
                    )));
  }
}
