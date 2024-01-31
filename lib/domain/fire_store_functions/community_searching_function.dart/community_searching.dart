import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';

abstract class CommunitySearch{
}

class CommunitySeachingFunctions extends CommunitySearch{
  CommunitySeachingFunctions._internal();
  static CommunitySeachingFunctions instance = CommunitySeachingFunctions._internal();
  factory CommunitySeachingFunctions() {
    return instance;
  }


}