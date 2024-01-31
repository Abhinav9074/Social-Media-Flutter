import 'package:connected/presentation/core/media_query/media_query.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/home/screens/post_view.dart';
import 'package:flutter/material.dart';

class HeadingAndImageWidget extends StatelessWidget {
  final bool isImage;
  final bool isText;
  final String title;
  final String image;
  final String text;
  final int index;
  final String discssionId;
  final String description;

  const HeadingAndImageWidget(
      {super.key,
      required this.isImage,
      required this.isText,
      required this.title,
      required this.image,
      required this.text,
      required this.index,
      required this.discssionId,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => PostViewPage(
                  discussionId: discssionId,
                  index: index,
                  image: image,
                  title: title,
                  description: description,
                )));
      },
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
              child: Hero(
                  tag: 'title$index',
                  child: Text(
                    title,
                    style: MyTextStyle.discussionHeadingText,
                    textScaler: TextScaler.noScaling,
                  )),
            ),
            image.isNotEmpty?Center(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Hero(
                      tag: 'image$index',
                      child: Image.network(
                        image,
                        width: MediaQueryCustom.disscussionImageWidth(context),
                        height:
                            MediaQueryCustom.disscussionImageHeight(context),
                        fit: BoxFit.fill,
                      ))),
            ):const SizedBox()
          ],
        ),
      ),
    );
  }
}
