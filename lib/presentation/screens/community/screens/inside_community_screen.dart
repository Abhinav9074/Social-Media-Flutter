import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/presentation/screens/community/widgets/bottom_tab.dart';
import 'package:connected/presentation/screens/community/widgets/community_appbar.dart';
import 'package:connected/presentation/screens/community/widgets/community_post.dart';
import 'package:flutter/material.dart';

class CommunityInsideView extends StatelessWidget {
  final String image;
  final String communityId;

  const CommunityInsideView({
    super.key,
    required this.image,
    required this.communityId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommunityAppBar(image: image, communityId: communityId),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Image.asset(
              'assets/images/community_background.png',
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Positioned(
              child: Column(
                children: [
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(FirebaseConstants.communityDb)
                          .doc(communityId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox();
                        } else {
                          return Expanded(
                              child: ListView.builder(
                                  reverse: true,
                                  itemCount: snapshot
                                      .data![
                                          FirebaseConstants.fieldCommunityPosts]
                                      .length,
                                  itemBuilder: (context, index) {
                                    final data = snapshot.data![FirebaseConstants.fieldCommunityPosts][snapshot.data![FirebaseConstants.fieldCommunityPosts].length-index-1];
                                    return CommunityPosts(postId: data);
                                  }));
                        }
                      }),
                  CommunityMessageTab(
                    communityId: communityId,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
