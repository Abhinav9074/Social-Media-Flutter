import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/add_details_screens/screens/add_details3.dart';
import 'package:connected/presentation/screens/add_details_screens/widgets/logo_heading.dart';
import 'package:connected/presentation/screens/add_details_screens/widgets/search_drop.dart';
import 'package:connected/presentation/screens/add_details_screens/widgets/selected_intrest.dart';
import 'package:flutter/material.dart';

class AddInterests extends StatelessWidget {
   const AddInterests({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:    SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Logo & Heading
               const Column(
                children: [
                  LogoAndHeading(heading: 'Your Interests'),
                            
                  //searchable dropdown
                  SearchDropDown(),
                            
                  //List the selected chips
                  SelectedInterestWidget(),
                ],
              ),
          
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> AddUserName()));
                  },
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black)), 
                  child: const Text('Continue',style: MyTextStyle.commonButtonTextWhite,),
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
