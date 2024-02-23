// ignore_for_file: use_build_context_synchronously


import 'package:connected/application/bloc/login_bloc/login_bloc.dart';
import 'package:connected/domain/shared_prefrences/login_logout/login_logout.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/login/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingSlider(
        onFinish: ()async{
          //setting the shared prefs 
          await SharedPrefLogin.setOnboardingStatus();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (ctx) {
            return BlocProvider(
              create: (context) => LoginBloc(),
              child: const LoginScreen(),
            );
          }), (route) => false);
        },
        finishButtonText: 'Login',
        finishButtonTextStyle: MyTextStyle.commonHeadingTextWhite,
        finishButtonStyle: const FinishButtonStyle(
          backgroundColor: Colors.red
        ),
        centerBackground: true,
        totalPage: 3, 
        headerBackgroundColor: Colors.white, 
        background: [
          Center(child: Lottie.asset('assets/lottie/onboarding1.json')),
          Center(child: Lottie.asset('assets/lottie/onboarding2.json')),
          Center(child: Lottie.asset('assets/lottie/onboarding3.json')),
        ], 
        speed: 1.8, 
        pageBodies: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                Text('Discuss Based On Your Interests',style: MyTextStyle.largeText,),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                Text('Connect with the whole world',style: MyTextStyle.largeText,),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                Text('Time to Begin, Lets Move',style: MyTextStyle.largeText,),
              ],
            ),
          ),
        ]),
    );
  }
}