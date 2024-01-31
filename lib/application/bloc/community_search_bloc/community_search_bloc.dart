import 'package:connected/application/bloc/community_search_bloc/community_search_event.dart';
import 'package:connected/application/bloc/community_search_bloc/community_search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunitySearchBloc extends Bloc<CommunitySearchEvent,CommunitySearchState>{
  CommunitySearchBloc(): super(CommunitySearchInitialState()){
    on<MyCommunitySearchingEvent>((event, emit){
      if(event.searchVal.isNotEmpty){
        emit(CommunitySearchedState(keyword: event.searchVal));
      }else{
        emit(NoCommunityState());
      }
    });

    on<OtherCommunitySearchingEvent>((event, emit){
      if(event.searchVal.isNotEmpty){
        emit(CommunitySearchedState(keyword: event.searchVal));
      }else{
        emit(NoCommunityState());
      }
    });
  }
}