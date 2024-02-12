abstract class AiGenerateState{}

class AiGenerateInitialState extends AiGenerateState{}

class AiGereratingState extends AiGenerateState{}

class AiGeneratedState extends AiGenerateState{
  final String generatedText;

  AiGeneratedState({required this.generatedText});
}