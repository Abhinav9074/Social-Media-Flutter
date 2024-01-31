import 'package:connected/application/bloc/community_name_bloc/community_name_event.dart';
import 'package:connected/application/bloc/community_name_bloc/community_name_state.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunityNameBloc extends Bloc<CommunityNameEvent, CommunityNameState> {
  CommunityNameBloc() : super(CommunityNameInitialState()) {

    //checking whether the community name exist or not
    on<CommunityNameChangeEvent>((event, emit) async {
      emit(CommunityNameCheckingState());
      if (event.communityName.isEmpty) {
        emit(NoCommunityNameState());
      } else if (await UserDbFunctions().checkValue(
              value: event.communityName,
              field: FirebaseConstants.fieldCommunityName,
              dbName: FirebaseConstants.communityDb) ==
          true) {
        emit(CommunityNameExistState());
      } else {
        emit(NewCommunityNameState());
      }
    });


  }
}
