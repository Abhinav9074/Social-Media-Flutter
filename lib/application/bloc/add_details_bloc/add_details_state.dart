abstract class AddDetailsState{}

class AddDetailsInitialState extends AddDetailsState{}

class InterestUpdatedState extends AddDetailsState{
  final List<String>interests;

  InterestUpdatedState({required this.interests});
}

class ReadyToGoState extends AddDetailsState{}

