abstract class CreateDiscussionEvent{}

class OnImagePickedEvent extends CreateDiscussionEvent{}

class DiscussionCreateEvent extends CreateDiscussionEvent{
  final String title;
  final String imageFile;
  final String description;
  final int likes;
  final int disLikes;
  final List<Map<String,String>>contributions;
  final bool edited;
  final List<String>tags;

  DiscussionCreateEvent({required this.title, required this.imageFile, required this.description, required this.likes, required this.disLikes, required this.contributions, required this.edited, required this.tags});
}
class DiscussionEditEvent extends CreateDiscussionEvent{
  final String title;
  final String imageFile;
  final String description;
  final String discussionId;
  final int likes;
  final int disLikes;
  final List<Map<String,String>>contributions;
  final bool edited;
  final List<String>tags;

  DiscussionEditEvent({required this.title, required this.imageFile, required this.description, required this.likes, required this.disLikes, required this.contributions, required this.edited, required this.tags,required this.discussionId});
}


