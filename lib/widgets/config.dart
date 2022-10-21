import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myfleet_project/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider {
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static SharedPreferences? sharedPreferences;
}
