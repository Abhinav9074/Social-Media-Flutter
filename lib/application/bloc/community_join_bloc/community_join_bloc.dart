import 'package:connected/application/bloc/community_join_bloc/community_join_event.dart';
import 'package:connected/application/bloc/community_join_bloc/community_join_state.dart';
import 'package:connected/domain/fire_store_functions/community_db/community_db_functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunityJoinBloc extends Bloc<CommunityJoinEvent,CommunityJoinState>{
  CommunityJoinBloc():super(CommunityJoinInitialState()){
    on<CommunityJoiningEvent>((event, emit)async{
      emit(CommunityJoinLoadingState());
      await CommunityDbFunctions().joinCommunity(event.communityId);
      if(event.communityType==true){
        emit(CommunityJoinRequestedState());
      }else{
        emit(CommunityJoinedState());
      }
    });
  }
}