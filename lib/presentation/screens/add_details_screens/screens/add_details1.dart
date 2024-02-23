import 'package:connected/application/bloc/add_details_bloc/add_details_bloc.dart';
import 'package:connected/application/bloc/add_details_bloc/add_details_event.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/add_details_screens/screens/add_details2.dart';
import 'package:connected/presentation/screens/add_details_screens/widgets/logo_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class AddGender extends StatelessWidget {
  final String password;

  const AddGender({super.key, required this.password});


  @override
  Widget build(BuildContext context) {
    TextEditingController usernameCont = TextEditingController();
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Logo & Heading
            const LogoAndHeading(heading: 'What should we call you ?'),

            //username field

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: usernameCont,
                onChanged: (value) {},
                decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.verified_user_sharp),
                    labelText: 'Enter Surname',
                    labelStyle: MyTextStyle.greyButtonText),
              ),
            ),


            Lottie.asset('assets/lottie/username.json'),

            ElevatedButton.icon(
              onPressed: (){
                BlocProvider.of<AddDetailsBloc>(context).add(AddSurnameEvent(realName: usernameCont.text.toLowerCase()));
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> AddInterests(password: password,)));
              }, 
              icon: const Icon(Icons.safety_check), label: const Text('Next'))
          ],
        ),
      ),
    );
  }
}
