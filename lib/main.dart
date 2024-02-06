import 'dart:developer';
import 'package:connected/application/bloc/add_details_bloc/add_details_bloc.dart';
import 'package:connected/application/bloc/community_posting_bloc/community_posting_bloc.dart';
import 'package:connected/application/bloc/contribution_bloc/contribution_bloc.dart';
import 'package:connected/application/bloc/image_picker_bloc/image_picker_bloc.dart';
import 'package:connected/application/bloc/login_bloc/login_bloc.dart';
import 'package:connected/application/bloc/other_profile_bloc/other_profile_bloc.dart';
import 'package:connected/application/bloc/splash_bloc/splash_bloc.dart';
import 'package:connected/application/bloc/user_access_bloc/user_access_bloc.dart';
import 'package:connected/application/bloc/user_name_bloc/username_bloc.dart';
import 'package:connected/presentation/screens/splash/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    log("Firebase Initialized Successfully");
  }).catchError((error) {
    log("Firebase Initialization Error: $error");
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
          BlocProvider(create: (context)=>SplashBloc()),
          BlocProvider(create: (context)=>LoginBloc()),
          BlocProvider(create: (context)=>AddDetailsBloc()),
          BlocProvider(create: (context)=>UsernameBloc()),
          BlocProvider(create: (context)=>ImagePickerBloc()),
          BlocProvider(create: (context)=>ContributionBloc()),
          BlocProvider(create: (context)=>OtherProfileBloc()),
          BlocProvider(create: (context)=>CommunityPostingBloc()),
          BlocProvider(create: (context)=>UserAccessBloc()),
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Social Media Application',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
