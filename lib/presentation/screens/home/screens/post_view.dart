import 'package:connected/presentation/core/media_query/media_query.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PostViewPage extends StatelessWidget {
  final String discussionId;
  final int index;
  final String image;
  final String title;
  final String description;
  
  const PostViewPage(
      {super.key,
      required this.discussionId,
      required this.index,
      required this.image,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        backgroundColor: Colors.black,
        title: Hero(
            tag: 'title$index',
            child: Text(
              title,
              style: MyTextStyle.commonButtonTextWhite,
            )),
      ),
      body: Column(
        children: [
          //post image
          image.isNotEmpty?Center(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Hero(
                    tag: 'image$index',
                    child: Image.network(
                      image,
                      width: MediaQueryCustom.disscussionImageWidth(context),
                      height: MediaQueryCustom.disscussionImageHeight(context),
                      fit: BoxFit.cover,
                      loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Lottie.asset(
                                    'assets/lottie/skeleton.json',
                                    width:
                                        MediaQueryCustom.disscussionImageWidth(
                                            context),
                                    height:
                                        MediaQueryCustom.disscussionImageHeight(
                                            context),
                                    fit: BoxFit.cover);
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Lottie.asset('assets/lottie/error.json',
                                    width:
                                        MediaQueryCustom.disscussionImageWidth(
                                            context),
                                    height:
                                        MediaQueryCustom.disscussionImageHeight(
                                            context),
                                    );
                              },
                    ))),
          ):const SizedBox(),

          //Post description
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: MediaQueryCustom.discussionContainerHeight(context),
              width: double.infinity,
              child: ListView(
                children:  [
                  const Text('Description',style: MyTextStyle.commonHeadingTextWhite,),
                  Text(description,style: MyTextStyle.commonDescriptionTextWhite,)
                ],
              ),
            ),
          )
          
        ],
      ),
    );
  }
}
