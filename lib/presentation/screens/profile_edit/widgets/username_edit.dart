import 'package:connected/application/bloc/user_name_bloc/username_bloc.dart';
import 'package:connected/application/bloc/user_name_bloc/username_event.dart';
import 'package:connected/application/bloc/user_name_bloc/username_state.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditUsername extends StatelessWidget {
  final TextEditingController userCont;
  const EditUsername({super.key, required this.userCont});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsernameBloc, UsernameState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            children: [
              TextFormField(
                controller: userCont,
                onChanged: (value) {
                  BlocProvider.of<UsernameBloc>(context)
                      .add(UsernameChangeEvent(username: value));
                },
                decoration: InputDecoration(
                    suffixIcon: state is UsernameCheckingState
                        ? Transform.scale(
                            scale: 0.3,
                            child: const CircularProgressIndicator())
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
                    labelStyle: MyTextStyle.greyButtonText,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
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
    );
  }
}
