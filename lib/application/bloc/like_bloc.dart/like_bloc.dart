import 'package:connected/application/bloc/like_bloc.dart/like_event.dart';
import 'package:connected/application/bloc/like_bloc.dart/like_state.dart';
import 'package:connected/domain/fire_store_functions/discussion_db/discussion_db_functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LikeBloc extends Bloc<LikeEvent,LikeState>{
  LikeBloc() : super(LikeInitialState()){
    
    on<AddLikeEvent>((event, emit)async{
      emit(AddLikeState());
      await DiscussionDbFunctions().likeDiscussion(event.discussionId);
    });
    
    on<RemoveLikeEvent>((event, emit)async{
      emit(RemoveLikeState());
      await DiscussionDbFunctions().removeLikeDiscussion(event.discussionId);
    });
  }
}