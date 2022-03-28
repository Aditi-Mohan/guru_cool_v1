import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pages/home_page.dart';

import 'commons/user.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/sign_board.png"),
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("GURUCOOL", style: TextStyle(
              color: Colors.lightBlue,
              fontSize: 45.0,
              fontFamily: 'Alpha',
            ),),
            Text("Holistic Learning", style: TextStyle(
              color: Colors.lightBlue,
              fontSize: 22.5,
              fontWeight: FontWeight.w900,
              fontFamily: 'Amatic',
            ),),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: RaisedButton(
                elevation: 5.0,
                color: Color.fromRGBO(255, 204, 153, 1),
                child: Hero(
                  tag: 'entery',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text("Enter", style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Alpha',
                          fontWeight: FontWeight.w600,
                          color: Colors.lightBlue,
                        ),),
                        Icon(Icons.arrow_forward),
                      ],
                    ),
                ),
                onPressed: () {
                  obj = new User.isLoggedIn();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(showSnackBarOnEntry: true,)), (Route<dynamic> route) => false);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
