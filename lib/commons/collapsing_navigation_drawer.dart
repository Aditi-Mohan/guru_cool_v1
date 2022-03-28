import 'package:flutter/material.dart';
import 'collapsing_list_tile.dart';
import 'theme.dart';
import 'user.dart';
import '/detail_pages/profile_page.dart';
import '/pages/about_page.dart';
import '/pages/vocabulary.dart';
import 'navigation_model.dart';
import '/pages/activities.dart';
import '/pages/home_page.dart';
import '/pages/recipes.dart';
import '/pages/reminders.dart';

int currSelectedCollapsingNavBar = 0;

List<Widget> pages = [
  HomePage(showSnackBarOnEntry: false,),
  Activities(),
  Recipes(),
  Reminders(),
  Vocabulary(),
  AboutPage(),
];

class CollapsingNavigationDrawer extends StatefulWidget {

  final int currSelected;

  CollapsingNavigationDrawer({this.currSelected});

  @override
  _CollapsingNavigationDrawerState createState() => _CollapsingNavigationDrawerState();
}

class _CollapsingNavigationDrawerState extends State<CollapsingNavigationDrawer> {

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 250.0,
        color: drawerBackgroundColor,
        child: Column(
          children: <Widget>[
//            PopupMenuButton<CustomPopUp>(
//              tooltip: "ADNVNJSNKCJNSFJNJ",
//              child: CollapsingListTile(
//                onTap: () {
//
//                },
//                isSelected: false,
//                icon: Icons.account_circle,
//                title: "${obj.name.toUpperCase()}",
//              ),
//              itemBuilder: (context) {
//                return <PopupMenuEntry<CustomPopUp>> [
//                  PopupMenuItem<CustomPopUp>(
//                    value: CustomPopUp(title: "edit", icon: Icons.edit),
//                    child: Text("edit"),
//                  ),
//                  PopupMenuItem<CustomPopUp>(
//                    value: CustomPopUp(title: "logout", icon: Icons.arrow_forward),
//                    child: Text("logout"),
//                  )
//                ];
//              },
//            ),
          CollapsingListTile(
            onTap: () {
              setState(() {
                currSelectedCollapsingNavBar = -1;
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ProfilePage()), (Route<dynamic> route) => false);
              });
            },
            isSelected: widget.currSelected == -1,
            title: "${obj.name.toUpperCase()}",
            icon: Icons.account_circle,
          ),
            Divider(
              height: 10.0,
              color: Colors.grey,
            ),
            Expanded(
              child:
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, counter ) {
                  return CollapsingListTile(
                      onTap: () {
                        setState(() {
                          currSelectedCollapsingNavBar = counter;
                          Navigator.pop(context);
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => pages[counter]), (Route<dynamic> routes) => false);
                        });
                      },
                      isSelected: widget.currSelected == counter,
                      title: list[counter].title,
                      icon: list[counter].icon,
                    );
                },
                separatorBuilder: (context, counter) {
                  return Divider(thickness: 3.0);
                },
                itemCount: list.length,
              ),
            )
          ],
        ),
      );
  }
}


class CustomPopUp {
  String title;
  IconData icon;

  CustomPopUp({this.title, this.icon});

}