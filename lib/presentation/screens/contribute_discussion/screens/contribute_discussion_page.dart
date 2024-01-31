import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/contribute_discussion/widget/contribution_ui.dart';
import 'package:connected/presentation/screens/contribute_discussion/widget/create_contribution.dart';
import 'package:connected/presentation/screens/contribute_discussion/widget/discussion_count.dart';
import 'package:flutter/material.dart';

class ContributeToDiscussionPage extends StatelessWidget {
  final String title;
  final String discussionId;
  final int count;

  const ContributeToDiscussionPage({super.key, required this.title, required this.discussionId,required this .count});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title,style: MyTextStyle.mediumHeadingText,),
      ),


      body:   Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           DiscussionCountWidget(count: count,),
          Expanded(child: ContributionUi(discussionId: discussionId,))

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>CreateContribution(discussionId: discussionId,)));
        },
        shape: const CircleBorder(),
        backgroundColor: Colors.red,
        child: const Icon(Icons.add,color: Colors.white,),
        ),
    );
  }
}