import 'package:connected/application/bloc/login_bloc/login_bloc.dart';
import 'package:connected/application/bloc/login_bloc/login_event.dart';
import 'package:connected/application/bloc/login_bloc/login_state.dart';
import 'package:connected/presentation/core/constants/texts.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc,LoginState>(
      builder: (context,state) {
        return ElevatedButton.icon(onPressed: ()async{ 
          BlocProvider.of<LoginBloc>(context).add(LoggedInEvent());
        }, icon: Image.asset('assets/icons/google.png',height: 30), label: const Padding(
                    padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
                    child: Text(TextConstants.googleText,style: MyTextStyle.googleButton,textScaler: TextScaler.noScaling,),
                  ));
      }
    );
  }
}