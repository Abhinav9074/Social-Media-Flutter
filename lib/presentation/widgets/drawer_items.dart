// ignore_for_file: use_build_context_synchronously

import 'package:connected/domain/shared_prefrences/login_logout/login_logout.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/login/screens/login_screen.dart';
import 'package:connected/presentation/screens/privacy_policy/screens/privacy_policy_screen.dart';
import 'package:connected/presentation/screens/settings/screens/settings_screen.dart';
import 'package:connected/presentation/screens/terms_and_conditions/screens/terms_and_conditions_screen.dart';
import 'package:connected/presentation/widgets/navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerItems extends StatelessWidget {
  const DrawerItems({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton.icon(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>const SettingsScreen()));
                  }, label: const Text('Settings',style: MyTextStyle.commonButtonText,),icon: const Icon(Icons.settings,color: Colors.grey,),),
                  TextButton.icon(onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>const PrivacyPolicyScreen()));}, label: const Text('Privacy Policy',style: MyTextStyle.commonButtonText,),icon: const Icon(Icons.privacy_tip,color: Colors.grey,),),
                  TextButton.icon(onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>const TermsAndConditions()));}, label: const Text('Terms & Conditions',style: MyTextStyle.commonButtonText,),icon: const Icon(Icons.info,color: Colors.grey,),),
                  TextButton.icon(onPressed: (){_launchUrl();}, label: const Text('About Developer',style: MyTextStyle.commonButtonText,),icon: const Icon(Icons.account_box_outlined,color: Colors.grey,),),
                  TextButton.icon(onPressed: (){}, label: const Text('Rate Us',style: MyTextStyle.commonButtonText,),icon: const Icon(Icons.rate_review,color: Colors.grey,),),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
            child: TextButton.icon(onPressed: ()async{
              await GoogleSignIn().signOut();
              FirebaseAuth.instance.signOut();
              await SharedPrefLogin.logOut();
              screenChangeNotifier.value=0;
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=>const LoginScreen()), (route) => false);
              await DefaultCacheManager().emptyCache();
            }, icon: const Icon(Icons.logout,color: Colors.red,), label: const Text('LogOut',style: MyTextStyle.logoutText,)),
          )
        ],
      ),
    );
  }

   Future<void> _launchUrl() async {
    final Uri url = Uri.parse('https://www.instagram.com/_abhin__av_/');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}