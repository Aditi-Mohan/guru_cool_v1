import 'package:flutter/material.dart';
import 'package:gurucoolv1/pages/home_page.dart';
import '/commons/collapsing_navigation_drawer.dart';
import '/commons/theme.dart';
import '/commons/user.dart';
import '/log_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("YOUR PROFILE", style: AppBarText.page,),
//        backgroundColor: Colors.blueGrey,
      ),
      drawer: CollapsingNavigationDrawer(currSelected: currSelectedCollapsingNavBar,),
//      backgroundColor: Colors.white70,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.account_circle, size: 250, color: HomepageBackgroundLight,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Username: ", style: TextStyle(color: selectedColor, fontSize: 20.0)),
                Text(obj.name, style: TextStyle(color: selectedColor, fontWeight: FontWeight.w900, fontSize: 25.0)),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
          onPressed: () async {
            setState(() {
              currSelectedCollapsingNavBar = 0;
            });
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.setBool('isLoggedIn', false);
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LogInPage()), (Route<dynamic> route) => false);
          },
          label: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("LOGOUT", style: AppBarText.page,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.arrow_forward, size: 25, color: Colors.white,),
            )
          ],),
        backgroundColor: Colors.redAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
