// ignore_for_file: use_build_context_synchronously

import 'package:connected/application/bloc/login_bloc/login_bloc.dart';
import 'package:connected/application/bloc/splash_bloc/splash_bloc.dart';
import 'package:connected/application/bloc/splash_bloc/splash_state.dart';
import 'package:connected/application/bloc/user_access_bloc/user_access_bloc.dart';
import 'package:connected/application/bloc/user_access_bloc/user_access_event.dart';
import 'package:connected/domain/shared_prefrences/login_logout/login_logout.dart';
import 'package:connected/presentation/screens/login/screens/login_screen.dart';
import 'package:connected/presentation/screens/main_page/screens/main_page.dart';
import 'package:connected/presentation/screens/onboarding/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) async{
        if (state is SplashLoadedState) {
          if(await SharedPrefLogin.checkOnBoardingStatus()==false){
           Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (ctx) {
            return BlocProvider(
              create: (context) => LoginBloc(),
              child: const LoginScreen(),
            );
          }), (route) => false);
          }else{
             Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>const OnboardingScreen()));
            
          }
        } else if (state is SplashLoggedInState) {
          BlocProvider.of<UserAccessBloc>(context).add(CheckUserAccess());
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (ctx) =>  const MainPage()),
              (route) => false);
        }
      },
      child: Scaffold(
        body: Center(child: Image.asset('assets/icons/splash.gif')),
      ),
    );
  }
}
