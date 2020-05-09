import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  String name;

  User({this.name});
  User.isLoggedIn() {
    getName();
  }

  Future<void> getName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    name = pref.get('name');
  }
}

User obj;