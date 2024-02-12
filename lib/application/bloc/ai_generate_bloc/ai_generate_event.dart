abstract class AiGenerateEvent{}

class GenerateClickEvent extends AiGenerateEvent{
  final String initialText;

  GenerateClickEvent({required this.initialText});
}

class EnhanceClickEvent extends AiGenerateEvent{
  final String initialText;

  EnhanceClickEvent({required this.initialText});
}