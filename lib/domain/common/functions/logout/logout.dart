import 'package:connected/domain/shared_prefrences/login_logout/login_logout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void>logOut()async{
  await GoogleSignIn().signOut();
              FirebaseAuth.instance.signOut();
              await SharedPrefLogin.logOut();
}