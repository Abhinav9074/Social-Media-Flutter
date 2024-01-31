import 'dart:io';

import 'package:connected/application/bloc/contribution_bloc/contribution_bloc.dart';
import 'package:connected/application/bloc/contribution_bloc/contribution_event.dart';
import 'package:connected/application/bloc/contribution_bloc/contribution_state.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateContribution extends StatelessWidget {
  final String discussionId;

  const CreateContribution({super.key, required this.discussionId});

  @override
  Widget build(BuildContext context) {
    TextEditingController textCont = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contribute',
          style: MyTextStyle.commonHeadingText,
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //contribution description
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
              child: TextFormField(
                controller: textCont,
                style: MyTextStyle.greyHeadingTextSmall,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type Something',
                  hintStyle: MyTextStyle.greyHeadingTextMedium,
                ),
                maxLines: 5,
              ),
            ),

            //selected image
            BlocBuilder<ContributionBloc, ContributionState>(
              builder: (context, state) {
                if (state is ImageSelectedState) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: FileImage(File(state.image)),
                              fit: BoxFit.fill)),
                      height: 200,
                      width: double.infinity,
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),

            //bottom access tools
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  BlocBuilder<ContributionBloc, ContributionState>(
                    builder: (context, state) {
                      if (state is ImageSelectedState) {
                        return IconButton(
                            onPressed: () {
                              BlocProvider.of<ContributionBloc>(context).add(
                                  ContributionCreateEvent(
                                      imageFile: state.image,
                                      description: textCont.text,
                                      discussionId: discussionId,
                                      edited: false));
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.send));
                      } else {
                        return IconButton(
                            onPressed: () {
                              BlocProvider.of<ContributionBloc>(context).add(
                                  ContributionCreateEvent(
                                      imageFile: '',
                                      description: textCont.text,
                                      discussionId: discussionId,
                                      edited: false));
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.send));
                      }
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
