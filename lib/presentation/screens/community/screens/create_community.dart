import 'dart:developer';

import 'package:connected/application/bloc/community_creation_bloc/community_creation_bloc.dart';
import 'package:connected/application/bloc/community_creation_bloc/community_creation_event.dart';
import 'package:connected/application/bloc/community_creation_bloc/community_creation_state.dart';
import 'package:connected/application/bloc/community_name_bloc/community_name_bloc.dart';
import 'package:connected/application/bloc/community_name_bloc/community_name_state.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/community/widgets/community_create_tile.dart';
import 'package:connected/presentation/screens/community/widgets/community_description.dart';
import 'package:connected/presentation/screens/community/widgets/private_or_public_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateCommunity extends StatelessWidget {
  const CreateCommunity({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController communityNameController = TextEditingController();
    TextEditingController communityDescController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Community',
          style: MyTextStyle.googleButton,
        ),
      ),
      body: Column(
        children: [
          //creation tile
          CommunityCreateTile(
            controller: communityNameController,
          ),

          const SizedBox(
            height: 20,
          ),
          //Description
          CommunityDescription(
            controller: communityDescController,
          ),

          //Private or Public
          const PrivateOrPublicSwitch()
        ],
      ),
      floatingActionButton: BlocBuilder<CommunityNameBloc, CommunityNameState>(
        builder: (context, state) {
          if (state is NewCommunityNameState) {
            return BlocConsumer<CommunityCreationBloc, CommunityCreationState>(
              listener: (context, state) {
                if(state is CommunityCreatingState){
                  Navigator.of(context).pop();
                }
              },
              builder: (context, state) {
                if(state is CommunityCreatingState){
                  return const CircularProgressIndicator();
                }else{
                  return FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<CommunityCreationBloc>(context).add(
                        CommunityCreatingEvent(
                            communityName: communityNameController.text,
                            communityDescription:
                                communityDescController.text));
                  },
                  backgroundColor: Colors.red,
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                );
                }
              },
            );
          } else {
            return FloatingActionButton(
              onPressed: () {},
              backgroundColor: const Color.fromARGB(255, 122, 121, 121),
              child: const Icon(
                Icons.check,
                color: Colors.white,
              ),
            );
          }
        },
      ),
    );
  }
}
