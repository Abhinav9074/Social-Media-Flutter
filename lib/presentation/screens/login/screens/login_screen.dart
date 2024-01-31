import 'package:connected/application/bloc/login_bloc/login_bloc.dart';
import 'package:connected/application/bloc/login_bloc/login_event.dart';
import 'package:connected/application/bloc/login_bloc/login_state.dart';
import 'package:connected/presentation/core/constants/texts.dart';
import 'package:connected/presentation/core/snackbars/common_snackbar.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/add_details_screens/screens/add_details1.dart';
import 'package:sign_button/sign_button.dart';
import 'package:connected/presentation/screens/login/widgets/icon_name.dart';
import 'package:connected/presentation/screens/main_page/screens/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is UserExistState) {
            AllSnackBars.commonSnackbar(context: context, title: 'Welcome Back', content: state.username, bg: Colors.green);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (ctx) =>  const MainPage()),
                (route) => false);
          } else if (state is NewUserState) {
            AllSnackBars.commonSnackbar(context: context, title: 'Success', content: state.username, bg: Colors.green);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (ctx) => const AddGender()),
                (route) => false);
          }
        },
        builder: (context, state) {
          if (state is LoginLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoginFailedState) {
            return const Center(child: Text('An Error Occured'));
          } else {
            return  SafeArea(
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const IconAndHeading(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SignInButton(
                          buttonType: ButtonType.google,
                          onPressed: (){
                            BlocProvider.of<LoginBloc>(context).add(LoggedInEvent());
                          },
                          buttonSize: ButtonSize.medium,
                          imagePosition: ImagePosition.left,
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 8, 0, 20),
                          child: SizedBox(
                              width: 370,
                              child: Center(
                                  child: Text(
                                TextConstants.policyText,
                                textAlign: TextAlign.center,
                                style: MyTextStyle.descriptionText,
                                textScaler: TextScaler.noScaling,
                              ))),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
