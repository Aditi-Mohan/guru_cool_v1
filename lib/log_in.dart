import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gurucoolv1/commons/theme.dart';
import 'pages/home_page.dart';
import 'commons/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {

  final FirebaseMessaging msg = FirebaseMessaging.instance;

  TextEditingController _name = TextEditingController();
  String token;

  bool _createToken = true;

  @override
  void initState() {
    super.initState();
    msg.getToken().then((token) {
      this.token = token;
    });
    getPrevName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LOG IN"),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
//                image: DecorationImage(image: AssetImage("assets/scenery.png"), fit: BoxFit.fitWidth),
//              color: HomepageBackgroundLight,
              ),
              child: Image.asset("assets/scenery.png", fit: BoxFit.fitWidth,),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("WELCOME", style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 40.0,
                            fontFamily: 'FFF',
                          ),),
                        ),
                        Text("to", style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 30.0,
                          fontFamily: 'FFF',
                        ),),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("GuruCool", style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 40.0,
                            fontFamily: 'Alpha',
                          ),),
                        ),
                      ]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: _name,
                    decoration: InputDecoration(
                      labelText: "Enter Name: ",
                      hintText: "Eg: Aditi",
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w900
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
//      Center(
//          child: Container(
//            decoration: BoxDecoration(
//              image: DecorationImage(image: AssetImage("assets/scenery.png"), fit: BoxFit.fitWidth),
////              color: HomepageBackgroundLight,
//            ),
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Column(
//                      children: <Widget>[
//                        Padding(
//                          padding: const EdgeInsets.all(8.0),
//                          child: Text("WELCOME", style: TextStyle(
//                              color: Colors.lightBlue,
//                              fontSize: 40.0,
//                              fontFamily: 'FFF',
//                          ),),
//                        ),
//                        Text("to", style: TextStyle(
//                          color: Colors.lightBlue,
//                          fontSize: 30.0,
//                          fontFamily: 'FFF',
//                        ),),
//                        Padding(
//                          padding: const EdgeInsets.all(8.0),
//                          child: Text("GuruCool", style: TextStyle(
//                              color: Colors.lightBlue,
//                              fontSize: 40.0,
//                              fontFamily: 'Alpha',
//                          ),),
//                        ),
//                      ]
//                  ),
//                ),
//                Padding(
//                  padding: const EdgeInsets.all(10.0),
//                  child: TextField(
//                    controller: _name,
//                    decoration: InputDecoration(
//                      labelText: "Enter Name: ",
//                      hintText: "Eg: Aditi",
//                      labelStyle: TextStyle(
//                          color: Colors.black,
//                          fontSize: 20.0,
//                          fontWeight: FontWeight.w900
//                      ),
//                      border: OutlineInputBorder(
//                        borderRadius: BorderRadius.circular(5.0),
//                        borderSide: BorderSide(color: Colors.blue),
//                      ),
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          ),
//        ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if(_name.text.isNotEmpty) {
            FirebaseFirestore.instance.collection('users')
                .doc('${_name.text}')
                .set({'name': '${_name.text}'});
            FirebaseFirestore.instance.collection('tokens')
                .doc('${_name.text}')
                .get()
                .then((docSnapshot) =>
            {
              _createToken = !docSnapshot.exists
            });
            if (_createToken)
              FirebaseFirestore.instance.collection('tokens')
                  .doc('${_name.text}')
                  .set({'devToken': '$token'});
            SharedPreferences pref = await SharedPreferences.getInstance();
            pref.setBool('isLoggedIn', true);
            pref.setString('name', _name.text);
            obj = new User(name: _name.text);
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(showSnackBarOnEntry: !_createToken,)), (Route<dynamic> route) => false);
          }
        },
        label: Text("JOIN!"),
      ),
    );
  }

  void getPrevName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.containsKey('name')?_name.text=pref.getString('name'):null;
  }
  //TODO: Change Appearance
  //TODO: Maybe box shadow?

}
