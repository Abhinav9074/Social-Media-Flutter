import 'package:connected/application/bloc/community_posting_bloc/community_posting_event.dart';
import 'package:connected/application/bloc/community_posting_bloc/community_posting_state.dart';
import 'package:connected/domain/fire_store_functions/community_db/community_post_functions.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/domain/models/community_model/community_post_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CommunityPostingBloc extends Bloc<CommunityPostingEvent,CommunityPostingState>{
  CommunityPostingBloc():super(CommunityPostingInitialState()){
    String imageFile;

    //image picking while posting in a community
    on<CommunityPostingImagePickEvent>((event, emit)async{
      emit(CommunityPostingNoImageState());
      imageFile='';
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image!=null){
        imageFile=image.path;
        emit(CommunityPostingImagePickedState(image: imageFile));
      }else{
        emit(CommunityPostingGoBackImageState());
      }
    });

    //submitting post in a community
    on<CommunityPostedEvent>((event, emit)async{
      emit(CommunityPostSubmittedState());
      await CommunityPostDbFunctions().createPost(CommunityPostModel(alert: false, communityId: event.communityId,image: event.image,message: event.description,userId: UserDbFunctions().userId,time: DateFormat.jm().toString()));
    });


  }
}