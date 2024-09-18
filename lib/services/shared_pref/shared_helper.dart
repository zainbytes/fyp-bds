import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  
  Future<void> setAvatar(String id) async{
    var prefs =await SharedPreferences.getInstance();
    await prefs.setString('avatar', id);
    

  }

  Future<String?> getAvatar() async{
    var prefs =await SharedPreferences.getInstance();
    var avatar= prefs.getString('avatar');
    return avatar;

  }
}