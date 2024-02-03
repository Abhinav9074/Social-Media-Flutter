abstract class ProfileSwitchState{}

class ProfileSwitchInitialState extends ProfileSwitchState{}

class ProfileSwitchToggledState extends ProfileSwitchState{
  final bool switchValue;

  ProfileSwitchToggledState({required this.switchValue});

}
