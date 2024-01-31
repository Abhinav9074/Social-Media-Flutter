import 'package:connected/application/bloc/community_search_bloc/community_search_bloc.dart';
import 'package:connected/application/bloc/community_search_bloc/community_search_event.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunitySerachBar extends StatelessWidget {
  const CommunitySerachBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: TextFormField(
        onChanged: (value){
          BlocProvider.of<CommunitySearchBloc>(context).add(MyCommunitySearchingEvent(searchVal: value));
        },
          decoration: const InputDecoration(
            hintStyle: MyTextStyle.greyHeadingTextSmall,
            hintText: 'Search Communities',
            prefixIcon: Icon(Icons.search,color: Color.fromARGB(255, 162, 161, 161),),
            contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            fillColor: Color.fromARGB(255, 220, 219, 219),
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none
            )
          ),
        ),
    );
  }
}