import 'package:connected/application/bloc/user_search_bloc/user_search_bloc.dart';
import 'package:connected/application/bloc/user_search_bloc/user_search_state.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/streams/discussion_search_stream.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/profile/screens/self_discussion_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SearchedDiscussion extends StatelessWidget {
  const SearchedDiscussion({super.key});

 @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserSearchBloc, UserSearchState>(
      builder: (context, state) {
        if (state is UserResultState) {
          return StreamBuilder(
              stream: discussionSearchStream(state.searchValue),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return  Lottie.asset('assets/lottie/no_user.json',height: 100,width: 100,frameRate: const FrameRate(90));
                }
                if (!snapshot.hasData) {
                  return  Lottie.asset('assets/lottie/no_user.json',height: 100,width: 100,frameRate: const FrameRate(90));
                }if(snapshot.data!.isEmpty){
                  return  Lottie.asset('assets/lottie/no_user.json',height: 100,width: 100,frameRate: const FrameRate(90));
                }
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final data = snapshot.data![index];
                      return InkWell(
                        onTap: () {
                          //navigating to discussion view page
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => SelfDiscussionView(discussionId: data['id'])));
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                data[FirebaseConstants.fieldDiscussionImage]),
                          ),
                          title: Text(data[FirebaseConstants.fieldDiscussionTitle],style: MyTextStyle.commonButtonText,),
                        ),
                      );
                    });
              });
        } else if (state is NoSearchValueState) {
          return  Lottie.asset('assets/lottie/no_user.json',height: 100,width: 100,frameRate: const FrameRate(90));
        } else {
          return  Lottie.asset('assets/lottie/no_user.json',height: 100,width: 100,frameRate: const FrameRate(90));
        }
      },
    );
  }
}