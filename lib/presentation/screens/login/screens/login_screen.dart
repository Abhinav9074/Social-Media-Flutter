// ignore_for_file: use_build_context_synchronously

import 'package:connected/application/bloc/login_bloc/login_bloc.dart';
import 'package:connected/application/bloc/login_bloc/login_event.dart';
import 'package:connected/application/bloc/login_bloc/login_state.dart';
import 'package:connected/domain/shared_prefrences/login_logout/login_logout.dart';
import 'package:connected/presentation/core/snackbars/common_snackbar.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/add_details_screens/screens/add_details1.dart';
import 'package:connected/presentation/screens/create_account/screens/create_account_screen.dart';
import 'package:connected/presentation/screens/login/widgets/custom_button.dart';
import 'package:connected/presentation/screens/login/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:connected/presentation/screens/main_page/screens/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:email_validator/email_validator.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final GlobalKey<FormState> passKey = GlobalKey<FormState>();
    TextEditingController emailCont = TextEditingController();
    TextEditingController passwordCont = TextEditingController();
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) async {
            if (state is NoUserState) {
              AllSnackBars.commonSnackbar(
                  context: context,
                  title: 'Invalid Credentials',
                  content: 'Invalid Credentials',
                  bg: const Color.fromARGB(255, 255, 0, 0));
            } else if (state is UserExistState) {
              AllSnackBars.commonSnackbar(
                  context: context,
                  title: 'Welcome Back',
                  content: state.username,
                  bg: Colors.green);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx) => const MainPage()),
                  (route) => false);
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
            } else if (state is UserBlockedState) {
              await GoogleSignIn().signOut();
              FirebaseAuth.instance.signOut();
              await SharedPrefLogin.logOut();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx) => const LoginScreen()),
                  (route) => false);
              AllSnackBars.commonSnackbar(
                  context: context,
                  title: 'Error',
                  content: 'Your Account Is Blocked',
                  bg: Colors.red);
            } else if (state is NoInternetState) {
              AllSnackBars.commonSnackbar(
                  context: context,
                  title: 'Please Check Internet Connection',
                  content: 'Please Check Internet Connection',
                  bg: Colors.red);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx) => const LoginScreen()),
                  (route) => false);
            } else if (state is LoginFailedState) {
              AllSnackBars.commonSnackbar(
                  context: context,
                  title: 'Login Failed Try Again',
                  content: 'Login Failed Try Again',
                  bg: Colors.red);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx) => const LoginScreen()),
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
                        Lottie.asset('assets/lottie/login.json',
                            width: 300, height: 300),

                        //WELCOME TEXT
                        const Text(
                          'Welcome Back !',
                          style: MyTextStyle.optionTextMediumLight,
                          textScaler: TextScaler.noScaling,
                        ),

                        //EMAIL FIELD
                        CustomCredentialTextField(
                          heading: 'E-mail address',
                          hint: 'Email',
                          controller: emailCont,
                          sufficIcon: const Icon(Icons.email),
                          formKey: formKey,
                          obscuredText: false,
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

                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                const CreateAccountScreen()));
                                  },
                                  child: const Text(
                                    'Register',
                                    style: MyTextStyle.commonButtonText,
                                  )),
                              BlocBuilder<LoginBloc, LoginState>(
                                builder: (context, state) {
                                  if (state is ManualLoginLoadingState) {
                                    return const CircularProgressIndicator();
                                  } else {
                                    return CustomButtonLogin(
                                      text: 'Login',
                                      icon: const Icon(
                                        Icons.arrow_right_alt,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          BlocProvider.of<LoginBloc>(context)
                                              .add(ManualLoginEvent(
                                                  email: emailCont.text,
                                                  password: passwordCont.text));
                                        }
                                      },
                                    );
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
                              'or Login with',
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
      ),
    );
  }
}
