import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/application/bloc/add_details_bloc/add_details_bloc.dart';
import 'package:connected/application/bloc/add_details_bloc/add_details_event.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SearchDropDown extends StatelessWidget {
  const SearchDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection(FirebaseConstants.interestsDb).doc(FirebaseConstants.interestDbId).snapshots(),
      builder: (context, snapshot) {
        
        if(!snapshot.hasData){
          return const Center(child: CircularProgressIndicator());
        }else{
          List<String>items = [];
        if(snapshot.data!=null){
          snapshot.data![FirebaseConstants.fieldInterests].forEach((e){
          items.add(e);
        });
        }
          if(items.isNotEmpty){
          return CustomDropdown<String>.search(
            hintText: 'Select Your Interests',
            excludeSelected: true,
            items:items.toSet().toList(),
            onChanged: (value) {
              BlocProvider.of<AddDetailsBloc>(context)
                  .add(AddInterestEvent(intrest: value));
            });
        }else{
          return const Center(child: CircularProgressIndicator());
        }
        }
      }
    );
  }
}
