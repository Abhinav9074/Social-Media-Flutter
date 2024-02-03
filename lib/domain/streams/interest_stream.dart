Stream<dynamic>interestStream({required List<dynamic> userInterest,required List<dynamic>deafultInterest})async*{

  List<String>tempList = [];
  Future.forEach(deafultInterest, (element){
    if(!userInterest.contains(element)){
      tempList.add(element);
    }
  });
  yield tempList;
}