import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'log_in.dart';
import '/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'commons/user.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {

  Future<void> check() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool _isLoggedIn = pref.getBool('isLoggedIn') ?? false;
    if (_isLoggedIn) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context) => WelcomePage()), (Route<dynamic> route) => false);
    }
    else
      Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context) => LogInPage()), (Route<dynamic> route) => false);
  }

  @override
  initState(){
    super.initState();
    check();
  }
/*
  Future<int> getFromSharedPref() async {
    final pref = await SharedPreferences.getInstance();
    final number = pref.getInt('number');
    if(number == null)
      return 0;
    else
      return number;
  }

  Future<void> incrementCounter() async {
    final pref = await SharedPreferences.getInstance();
    final last_num = await getFromSharedPref();
    final curr_num = last_num+1;
    num = '$curr_num times';
    pref.setInt('number', curr_num);
  }
*/
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
