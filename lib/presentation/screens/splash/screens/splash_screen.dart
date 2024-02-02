import 'package:connected/application/bloc/login_bloc/login_bloc.dart';
import 'package:connected/application/bloc/splash_bloc/splash_bloc.dart';
import 'package:connected/application/bloc/splash_bloc/splash_state.dart';
import 'package:connected/application/bloc/user_access_bloc/user_access_bloc.dart';
import 'package:connected/application/bloc/user_access_bloc/user_access_event.dart';
import 'package:connected/presentation/screens/login/screens/login_screen.dart';
import 'package:connected/presentation/screens/main_page/screens/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) async{
        if (state is SplashLoadedState) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (ctx) {
            return BlocProvider(
              create: (context) => LoginBloc(),
              child: const LoginScreen(),
            );
          }), (route) => false);
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
