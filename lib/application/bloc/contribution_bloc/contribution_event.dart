abstract class ContributionEvent{}

class OnImagePickedEvent extends ContributionEvent{}

class ContributionCreateEvent extends ContributionEvent{
  final String imageFile;
  final String description;
  final String discussionId;
  final bool edited;

  ContributionCreateEvent({required this.imageFile, required this.description, required this.discussionId, required this.edited});

 
}