import 'package:connected/application/bloc/community_creation_bloc/community_creation_bloc.dart';
import 'package:connected/application/bloc/community_creation_bloc/community_creation_event.dart';
import 'package:connected/application/bloc/community_creation_bloc/community_creation_state.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrivateOrPublicSwitch extends StatelessWidget {
  const PrivateOrPublicSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
        child: ListTile(
          title: const Text(
            'Private Community',
            style: MyTextStyle.optionTextMedium,
          ),
          subtitle: const Text(
            'User can join only with approval of admin',
            style: MyTextStyle.smallText,
          ),
          trailing: BlocBuilder<CommunityCreationBloc, CommunityCreationState>(
            builder: (context, state) {
              return Builder(
                builder: (context) {
                  if(state is CommunityImagePickedState){
                    return Switch(
                    value: state.val,
                    onChanged: (value) {
                      BlocProvider.of<CommunityCreationBloc>(context)
                          .add(CommunitySwitchTappedEvent());
                    },
                    activeColor: Colors.red,
                  );
                  }else if(state is CommunitySwitchState){
                    return Switch(
                    value: state.val,
                    onChanged: (value) {
                      BlocProvider.of<CommunityCreationBloc>(context)
                          .add(CommunitySwitchTappedEvent());
                    },
                    activeColor: Colors.red,
                  );
                  }else{
                    return Switch(
                    value: false,
                    onChanged: (value) {
                      BlocProvider.of<CommunityCreationBloc>(context)
                          .add(CommunitySwitchTappedEvent());
                    },
                    activeColor: Colors.red,
                  );
                  }
                }
              );
            },
          ),
        ));
  }
}
