import 'package:flutter/material.dart';

class MediaQueryCustom {
  static appBarHeight(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.06;
  }
  static discussionTabHeight(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.06;
  }

  static interestSectionHeight(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.25;
  }

  static interestSectionWidth(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.4;
  }

  static disscussionImageHeight(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.25;
  }

  static disscussionImageWidth(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.43;
  }

  static profilePicSize(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.06;
  }

  static discussionContainerHeight(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.6;
  }
  static carouselHeight(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.7;
  }

  static imageTextCreateContainerHeight(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.7;
  }
  static imageTextCreateContainerWidth(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.9;
  }
}
