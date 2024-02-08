import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/home/widgets/user_details.dart';
import 'package:flutter/material.dart';

class ContributionUi extends StatelessWidget {
  final String discussionId;

  const ContributionUi({super.key, required this.discussionId});




  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection(FirebaseConstants.contributionDb).where(FirebaseConstants.fieldDiscussionDiscussionId,isEqualTo: discussionId).snapshots(), 
    builder: (context,snapshot){
      if(!snapshot.hasData){
        return const SizedBox();
      }else{
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context,index){
            final data = snapshot.data!.docs[index];
            return  SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserDeatilsTile(userId: data[FirebaseConstants.fieldContributer],time: data[FirebaseConstants.fieldContributedTime],index: index,edited: false,discussionId: discussionId,),
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 20),
                     child: Text(data[FirebaseConstants.fieldContributionDescription],style: MyTextStyle.descriptionText,),
                   )
                ],
              ),
            );
          });
      }
    });
  }
}