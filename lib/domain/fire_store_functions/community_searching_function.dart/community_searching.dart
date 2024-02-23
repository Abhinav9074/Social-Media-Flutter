

abstract class CommunitySearch{
}

class CommunitySeachingFunctions extends CommunitySearch{
  CommunitySeachingFunctions._internal();
  static CommunitySeachingFunctions instance = CommunitySeachingFunctions._internal();
  factory CommunitySeachingFunctions() {
    return instance;
  }


}