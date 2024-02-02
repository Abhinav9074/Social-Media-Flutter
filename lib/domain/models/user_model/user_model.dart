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
  final String phno;
  final List<String> following;
  final List<String> followers;
  final List<String> interest;
  final List<String> discussions;
  final List<String> communities;
  final List<String> communitiyNames;
  final List<String> requestedCommunities;
  final List<String> liked;
  final List<String> disliked;
  final bool blocked;

  UserModel(
      {required this.username,
      required this.email,
      required this.image,
      required this.realName,
      required this.gender,
      required this.locationStr,
      required this.location,
      required this.createdTime,
      required this.phno,
      required this.following,
      required this.followers,
      required this.interest,
      required this.discussions,
      required this.liked,
      required this.disliked,
      required this.communities,
      required this.requestedCommunities,
      required this.communitiyNames,
      required this.blocked
      });

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
      FirebaseConstants.filedDisliked: disliked,
      FirebaseConstants.filedGender: gender,
      FirebaseConstants.filedLocationStr: locationStr,
      FirebaseConstants.filedLocation: location,
      FirebaseConstants.filedCreatedTime: createdTime,
      FirebaseConstants.filedPhone: phno,
      FirebaseConstants.fieldCommunities: communities,
      FirebaseConstants.fieldRequestedCommunities:requestedCommunities,
      FirebaseConstants.fieldCommunitiyNames:communitiyNames,
      FirebaseConstants.fieldUserBlocked:blocked
    };
  }
}
