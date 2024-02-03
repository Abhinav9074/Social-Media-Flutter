abstract class ProfileSwitchEvent{}

class ProfileSwitchTapEvent extends ProfileSwitchEvent{
  final bool currentStatus;

  ProfileSwitchTapEvent({required this.currentStatus});
}