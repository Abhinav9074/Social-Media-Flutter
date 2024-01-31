import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefLogin {

  //Set login status to true in shared prefrences
  static Future<void> setLogin() async {
    final instance = await SharedPreferences.getInstance();
    await instance.setBool('Login', true);
  }

  //Set login status to false in shared prefrences
  static Future<void> logOut() async {
    final shared = await SharedPreferences.getInstance();
    shared.setBool('Login', false);
    shared.setString('email','');
  }

  //check login status
  static Future<bool> checkLogin() async {
    final shared = await SharedPreferences.getInstance();
    if(shared.getBool('Login')==true){
      return true;
    }
    return false;
  }


  //save user ID in shared prefrences
  static Future<void>saveId(String id)async{
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString('userId', id);
  }

  //get User Id in shared prefrences
  static Future<String>getUserId()async{
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString('userId')!;
  }

   //save user ID in shared prefrences
  static Future<void>saveEmail(String email)async{
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString('email', email);
  }

  //get User Id in shared prefrences
  static Future<String>getEmail()async{
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString('email')!;
  }
}
