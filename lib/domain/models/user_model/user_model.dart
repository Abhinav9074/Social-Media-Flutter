
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/models/common_mixin/firestore_mixin.dart';


class UserModel with FirestoreModel {
  final String username;
  final String email;
  final String image;
  final String realName;
  final String gender;
  final String locationStr;  
  final dynamic location;
  final DateTime createdTime;
  final int notificationCount;
  final List<String> following;
  final List<String> followers;
  final List<String> interest;
  final List<String> discussions;
  final List<String> communities;
  final List<String> communitiyNames;
  final List<String> requestedCommunities;
  final List<String> liked;
  final List<String> notifications;
  final List<Map<String,String>> chat;
  final List<String> savedDiscussion;
  final bool blocked;
  final bool locationView;
  final double lattitude;
  final double longitude;
  final String address;
  final String bio;
  final bool premium;
  final String password;
  final bool isGoogle;

  UserModel({required this.username, required this.email, required this.image, required this.realName, required this.gender, required this.locationStr, required this.location, required this.createdTime, required this.notificationCount, required this.following, required this.followers, required this.interest, required this.discussions, required this.communities, required this.communitiyNames, required this.requestedCommunities, required this.liked, required this.notifications, required this.blocked, required this.locationView, required this.lattitude, required this.longitude, required this.address,required this.bio,required this.premium,required this.chat,required this.savedDiscussion,required this.password,required this.isGoogle});



  @override
  Map<String, dynamic> toMap() {
    return {
      FirebaseConstants.fieldEmail: email,
      FirebaseConstants.fieldusername: username,
      FirebaseConstants.fieldImage: image,
      FirebaseConstants.fieldInterest: interest,
      FirebaseConstants.fieldRealname: realName,
      FirebaseConstants.fieldFollowers: followers,
      FirebaseConstants.fieldFollowing: following,
      FirebaseConstants.fieldDiscussions: discussions,
      FirebaseConstants.fieldLiked: liked,
      FirebaseConstants.filedNotifications: notifications,
      FirebaseConstants.filedGender: gender,
      FirebaseConstants.filedLocationStr: locationStr,
      FirebaseConstants.filedLocation: location,
      FirebaseConstants.filedCreatedTime: createdTime,
      FirebaseConstants.fieldNotificationCount: notificationCount,
      FirebaseConstants.fieldCommunities: communities,
      FirebaseConstants.fieldRequestedCommunities:requestedCommunities,
      FirebaseConstants.fieldCommunitiyNames:communitiyNames,
      FirebaseConstants.fieldUserBlocked:blocked,
      FirebaseConstants.fieldAddress:address,
      FirebaseConstants.fieldLattitude:lattitude,
      FirebaseConstants.fieldLongitude:longitude,
      FirebaseConstants.fieldAllowLocationView:locationView,
      FirebaseConstants.fieldUserBio:bio,
      FirebaseConstants.fieldPremiumUser:premium,
      FirebaseConstants.fieldChats:chat,
      FirebaseConstants.fieldSavedDiscussions:savedDiscussion,
      FirebaseConstants.fieldPassword:password,
      FirebaseConstants.fieldIsGoogle:isGoogle
    };
  }
}
