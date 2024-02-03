

import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/models/common_mixin/firestore_mixin.dart';

class UserUpdateModel with FirestoreModel {
  
  final String image;
  final String realName;
  final bool locationView;
  final String address;
  final String bio;

  UserUpdateModel({required this.image, required this.realName, required this.locationView, required this.address, required this.bio});





  @override
  Map<String, dynamic> toMap() {
    return {
      FirebaseConstants.fieldImage: image,
      FirebaseConstants.fieldRealname: realName,
      FirebaseConstants.fieldAddress:address,
      FirebaseConstants.fieldAllowLocationView:locationView,
      FirebaseConstants.fieldUserBio:bio,
    };
  }
}
