// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:connected/application/bloc/login_bloc/login_bloc.dart';
import 'package:connected/application/bloc/login_bloc/login_event.dart';
import 'package:connected/application/bloc/login_bloc/login_state.dart';
import 'package:connected/presentation/core/snackbars/common_snackbar.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/add_details_screens/screens/add_details1.dart';
import 'package:connected/presentation/screens/login/screens/login_screen.dart';
import 'package:connected/presentation/screens/login/widgets/custom_button.dart';
import 'package:connected/presentation/screens/login/widgets/custom_textfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:lottie/lottie.dart';
import 'package:connected/presentation/screens/main_page/screens/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final GlobalKey<FormState> passKey = GlobalKey<FormState>();
    final GlobalKey<FormState> confirmPassKey = GlobalKey<FormState>();
    TextEditingController emailCont = TextEditingController();
    TextEditingController passwordCont = TextEditingController();
    TextEditingController confirmPasswordCont = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) async {
          if (state is UserExistState) {
            AllSnackBars.commonSnackbar(
                context: context,
                title: 'Welcome Back',
                content: state.username,
                bg: Colors.green);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (ctx) => const MainPage()),
                (route) => false);
          } else if (state is NoUserState) {
            AllSnackBars.commonSnackbar(
                context: context,
                title: 'Email',
                content: 'Email Already Exist',
                bg: const Color.fromARGB(255, 255, 0, 0));
          } else if (state is NewUserState) {
            AllSnackBars.commonSnackbar(
                context: context,
                title: 'Success',
                content: state.username,
                bg: Colors.green);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (ctx) => AddGender(
                          password: passwordCont.text.isEmpty
                              ? ''
                              : passwordCont.text,
                        )),
                (route) => false);
          } else if (state is NoInternetState) {
            AllSnackBars.commonSnackbar(
                context: context,
                title: 'Please Check Internet Connection',
                content: 'Please Check Internet Connection',
                bg: Colors.red);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (ctx) => const CreateAccountScreen()),
                (route) => false);
          } else if (state is LoginFailedState) {
            AllSnackBars.commonSnackbar(
                context: context,
                title: 'Login Failed Try Again',
                content: 'Login Failed Try Again',
                bg: Colors.red);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (ctx) => const CreateAccountScreen()),
                (route) => false);
          }
        },
        builder: (context, state) {
          if (state is LoginLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoginFailedState) {
            return const Center(child: Text('An Error Occured'));
          } else {
            return SafeArea(
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //HEAD ANIMATION
                      Lottie.asset('assets/lottie/signup.json',
                          width: 200, height: 200),

                      //WELCOME TEXT
                      const Text(
                        'Start your never ending journey',
                        style: MyTextStyle.optionTextMediumLight,
                        textScaler: TextScaler.noScaling,
                      ),

                      //EMAIL FIELD
                      CustomCredentialTextField(
                        heading: 'E-mail address',
                        hint: 'Email',
                        obscuredText: false,
                        controller: emailCont,
                        sufficIcon: const Icon(Icons.email),
                        formKey: formKey,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email address.';
                          }
                          if (!EmailValidator.validate(value)) {
                            return 'Please enter a valid email address.';
                          }
                          return null;
                        },
                      ),

                      //PASSWORD FIELD
                      CustomCredentialTextField(
                        heading: 'Password',
                        hint: 'Password',
                        obscuredText: true,
                        controller: passwordCont,
                        sufficIcon: const Icon(Icons.password),
                        formKey: passKey,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter a password';
                          }
                          return null;
                        },
                      ),

                      //CONFIRM PASSWORD FIELD
                      CustomCredentialTextField(
                        heading: 'Password',
                        hint: 'Password',
                        obscuredText: true,
                        controller: passwordCont,
                        sufficIcon: const Icon(Icons.password),
                        formKey: confirmPassKey,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter a password';
                          }
                          return null;
                        },
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (ctx) =>
                                              const LoginScreen()),
                                      (route) => false);
                                },
                                child: const Text(
                                  'Login',
                                  style: MyTextStyle.commonButtonText,
                                )),
                            CustomButtonLogin(
                              text: 'Register',
                              icon: const Icon(
                                Icons.arrow_right_alt,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                log(emailCont.text);
                                if (emailCont.text.trim().isNotEmpty &&
                                    passwordCont.text ==
                                        confirmPasswordCont.text) {
                                  BlocProvider.of<LoginBloc>(context).add(
                                      ManualSignUpEvent(
                                          email: emailCont.text,
                                          password: passwordCont.text));
                                }
                              },
                            )
                          ],
                        ),
                      ),

                      //DIVIDER
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20, 50, 20, 50),
                        child: Divider(),
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'or SignUp with',
                            style: MyTextStyle.greyHeadingTextSmall,
                          ),
                          IconButton(
                              onPressed: () {
                                BlocProvider.of<LoginBloc>(context)
                                    .add(LoggedInEvent());
                              },
                              icon: Image.asset(
                                'assets/icons/google.png',
                                width: 50,
                                height: 50,
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
