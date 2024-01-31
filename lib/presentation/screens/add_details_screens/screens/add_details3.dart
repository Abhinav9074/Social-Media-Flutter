import 'package:connected/application/bloc/add_details_bloc/add_details_bloc.dart';
import 'package:connected/application/bloc/add_details_bloc/add_details_event.dart';
import 'package:connected/application/bloc/user_name_bloc/username_bloc.dart';
import 'package:connected/application/bloc/user_name_bloc/username_event.dart';
import 'package:connected/application/bloc/user_name_bloc/username_state.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/add_details_screens/screens/add_details4.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class AddUserName extends StatelessWidget {
  AddUserName({super.key});

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Logo & Heading
                  Image.asset(
                    'assets/icons/icon-yellow.png',
                    height: 60,
                    width: 60,
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    child: Row(
                      children: [
                        Text(
                          'Choose a Username',
                          style: MyTextStyle.commonHeadingText,
                          textScaler: TextScaler.noScaling,
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                    child: Row(
                      children: [
                        Text(
                          'Your Username is your identity in this App,\nMake sure to make it special and unique',
                          style: MyTextStyle.descriptionText,
                          textScaler: TextScaler.noScaling,
                        )
                      ],
                    ),
                  ),
              
                  //username field
              
                  BlocBuilder<UsernameBloc, UsernameState>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: controller,
                              onChanged: (value) {
                                BlocProvider.of<UsernameBloc>(context)
                                    .add(UsernameChangeEvent(username: value));
                              },
                              decoration: InputDecoration(
                                  suffixIcon: state is UsernameCheckingState
                                      ? Transform.scale(
                                          scale: 0.3,
                                          child:
                                              const CircularProgressIndicator())
                                      : state is UsernameExistState
                                          ? const Icon(
                                              Icons.close,
                                              color: Colors.red,
                                            )
                                          : state is NewUsernameState
                                              ? const Icon(
                                                  Icons.check,
                                                  color: Colors.green,
                                                )
                                              : state is NoUsernameState
                                                  ? const SizedBox()
                                                  : const SizedBox(),
                                  labelText: 'Enter Username',
                                  labelStyle: MyTextStyle.greyButtonText),
                              validator: (value) {
                                if (RegExp(r'^[^\s]+$').hasMatch(value!)) {
                                  return null; 
                                } else {
                                  return 'username should not contain any spaces';
                                }
                              },
                            ),
                            Row(
                              children: [
                                state is UsernameExistState
                                    ? const Text(
                                        'Username already Exist',
                                        style: MyTextStyle.errorText,
                                      )
                                    : state is NewUsernameState
                                        ? const Text(
                                            'Username Available',
                                            style: MyTextStyle.successText,
                                          )
                                        : state is UsernameMinLengthState
                                            ? const Text(
                                                'Minimum length 6',
                                                style: MyTextStyle.errorText,
                                              )
                                            : const SizedBox(),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
              
                  //background icon
              
                  Image.asset(
                    'assets/icons/user_back.png',
                    height: 400,
                    width: 400,
                  ),
              
                  //button
                  BlocBuilder<UsernameBloc, UsernameState>(
                    builder: (context, state) {
                      if (state is NewUsernameState) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: ElevatedButton(
                            onPressed: () async {
                              if(formkey.currentState!.validate()){
                                BlocProvider.of<AddDetailsBloc>(context).add(
                                  AddUserNameEvent(username: controller.text));
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => const AddProfilePicture()));
                              BlocProvider.of<UsernameBloc>(context)
                                  .add(UserNameResetEvent());
                              }
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black)),
                            child: const Text(
                              'Continue',
                              style: MyTextStyle.commonButtonTextWhite,
                            ),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 145, 143, 143))),
                            child: const Text(
                              'Continue',
                              style: MyTextStyle.commonButtonTextWhite,
                            ),
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
