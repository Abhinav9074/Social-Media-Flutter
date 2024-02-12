import 'dart:developer';

import 'package:connected/application/bloc/ai_generate_bloc/ai_generate_event.dart';
import 'package:connected/application/bloc/ai_generate_bloc/ai_generate_state.dart';
import 'package:connected/domain/common/functions/gemini_functions/gemini_functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiGenerateBloc extends Bloc<AiGenerateEvent,AiGenerateState>{
  AiGenerateBloc() : super (AiGenerateInitialState()){


    on<GenerateClickEvent>((event, emit)async{
      log(event.initialText);
      emit(AiGereratingState());

      String description = await GeminiFunctions().aiGenerate(initialKeywords: event.initialText);

      emit(AiGeneratedState(generatedText: description));
    });

    on<EnhanceClickEvent>((event, emit)async{
      emit(AiGereratingState());

      String description = await GeminiFunctions().aiEnhance(text: event.initialText);

      emit(AiGeneratedState(generatedText: description));
    });
  }
}